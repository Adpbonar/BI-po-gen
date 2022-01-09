class Statement < ApplicationRecord
    belongs_to :po
    has_many :line_items
    has_many :payments
    has_one :statement_note
    encrypts :participant_address, :participant_name
    encrypts :statement_participant, type: :integer

    validates :status_code, length: {is: 1}, allow_blank: true

    require 'bigdecimal'

    def locked
        if self.type == 'GeneralStatement'
            if self.status_code == 'A' || self.status_code == 'L'
                return true
            end
        end
      end
        
    def percentage_amount(record1, record2)
        return (record1.to_i * ("0." + record2.to_s).to_f)
    end

    def subtotal
        cost = 0.0
        self.po.installments.map { |installment| cost = cost + installment.cost }
        return cost.to_d
    end

    def cost
        cost = 0.0
        items =  self.po.statements.first.line_items.order(:id)
        items.each do |item|
            if item.discounts.any?
                unless item.calculate_discounts == "Free"
                    cost = cost + item.calculate_discounts
                end
            else
                if item.type == 'ExpenseItem' && ! item.expense_exempt_from_tax
                    cost = cost + item.calculate_discounts + percentage_amount(item.cost, item.statement.po.tax_amount)
                else
                    cost = cost + item.cost
                end
            end
        end
        return (cost * ("0." + self.percentage.to_s).to_f).to_d
    end


    def generate_associate_statement
        ass_users = self.po.po_users
        PoUser.destroy_duplicates_by(:participant_id, :po_id)
        if self.po.status == 'Prepared' && self.po.statements.count == 1 && self.type == 'GeneralStatement' 
            unless self.po.found.blank?
                initiator = Participant.find(self.po.found.to_i)
                if initiator
                    founder_statement = AssociateStatement.create(po_id: self.po.id, total: percentage_amount(self.subtotal.to_d, self.po.founder_percentage), company_name: initiator.company, participant_name: initiator.name, participant_address: initiator.address, invoice_number: self.po.po_number.to_s + '-I')
                    self.line_items.each do |item|
                        LineItem.create(statement_id: founder_statement.id, type: item.type, title: item.title, description: item.description, cost: item.cost, taxable: item.taxable, expense_exempt_from_tax: item.expense_exempt_from_tax, expense_cost: item.expense_cost)
                        if item.discounts.any?
                            item.discounts.each do |discount|
                                Discount.create(amount: discount.amount, amount_type: discount.amount_type, line_item_id: discount.line_item_id)
                            end
                        end
                    end
                end
            end 
            expense_items = self.line_items.all.where(type: 'ExpenseItem')
            expenses = 0.0
            if expense_items.any?
                expense_items.each do |expense|
                    if ! expense.expense_exempt_from_tax == true && ! expense.expense_cost == nil
                        expenses = expenses + expense.expense_cost.to_d + percentage_amount(expense.cost.to_d, self.po.tax_amount)
                    else
                        expenses = expenses + expense.expense_cost.to_d
                    end
                end
            end
            total = (percentage_amount(self.subtotal.to_d, self.po.associate_percentage) - expenses) / ass_users.count
            ass_users.each do |user|
                usr = user.participant
                if usr.type == 'Associate'
                    associate_statement = AssociateStatement.create(po_id: self.po.id, total: total, participant_name: usr.name, participant_address: usr.address, company_name: self.po.company_name, invoice_number: self.po.po_number.to_s + '-' + usr.id.to_s)
                    self.line_items.each do |item|
                        LineItem.create(statement_id: associate_statement.id, type: item.type, title: item.title, description: item.description, cost: item.cost, taxable: item.taxable, expense_exempt_from_tax: item.expense_exempt_from_tax, expense_cost: item.expense_cost)
                        if item.discounts.any?
                            item.discounts.each do |discount|
                                Discount.create(amount: discount.amount, amount_type: discount.amount_type, line_item_id: discount.line_item_id)
                            end
                        end
                    end
                    StatementMailer.pdf_attachment(associate_statement).deliver
                end
            end
        end
        if ass_users.count > 0 && self.po.statements.all.where(type: 'AssociateStatement').count >= 1
            self.po.update(status: 'Associate Submitted')
            self.update(status_code: 'A')
        end
    end

    def generate_client_statement
        if ass_users.count > 0 && self.po.statements.all.where(type: 'ClientStatement').count >= 1
            self.po.update(status: 'All Statements Submitted')
            self.update(status_code: 'L')
        end
    end

    def pdf_installment_chart
        installments = Array.new
        self.po.installments.order(:position).each do |portion|
            temp = Array.new
            installment =  'Installment ' + portion.position.to_s
            value = portion.percentage
            temp << installment
            temp << value
            installments << temp
        end
        return installments
    end
end
