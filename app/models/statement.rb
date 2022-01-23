class Statement < ApplicationRecord
    belongs_to :po
    has_many :line_items
    has_many :payments
    has_one :statement_note
    encrypts :participant_address, :participant_name
    encrypts :statement_participant, type: :integer

    validates :status_code, length: {is: 1}, allow_blank: true

    require 'bigdecimal'

    def self.model_name
        return super if self == Statement
        Statement.model_name
    end

    def send_out_statement
        StatementMailer.pdf_attachment(self).deliver 
    end

    def locked
        if self.type == 'GeneralStatement'
            if self.status_code == 'A' || self.status_code == 'L'
                return true
            end
        end
      end
        
    def percentage_amount(record1, record2)
        if record2.to_s.split(".").to_s[0] == "0" || record2.to_s[0] == "."
            return (record1.to_i * ("0." + record2.to_s.split(".").last.to_s).to_f)
        else
            if record2.to_s.split(".").first.size < 2
                return (record1.to_i * ("0.0" + record2.to_s.split(".").join).to_f)
            else
                return (record1.to_i * ("0." + record2.to_s).to_f)
            end
        end
    end

    def associate 
        return true if self.type == "AssociateStatement"
    end

    def client 
        return true if self.type == "ClientStatement"
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

    def number_participating_associates
        counter = []
        Participant.all.where(type: "Associate").each do |user|
            self.po.po_users.where(po_id: self.po.id).each do |participant|
                if participant.participant_id == user.id
                    counter << 1
                end
            end
        end
        return counter.length
    end

    def send_assocate_statements
        StatementMailer.pdf_attachment(self).deliver
    end

    def no_general
        if self.type == "GeneralStatement" && self.status_code == "A"
            return true
        end
    end

    def founder
        if self.invoice_number.include?("F")
            return true
        end
    end

    def rs
        if self.invoice_number.include?("RS")
            return true
        end
    end

    def set_invoice_number
        last_invoice = Statement.where(type: "ClientStatement").last
        unless last_invoice == nil
            last_number = (last_invoice.invoice_number.split("-").last.to_i + 1).to_s
            return "INV-" + last_number
        else
            return "INV-" + self.po.invoice_number.to_s + .strftime("%y").to_s + "10"
        end
    end

    def generate_associate_statement
        ass_users = self.po.po_users.all
        PoUser.destroy_duplicates_by(:participant_id, :po_id)
        if self.po.status == 'Prepared' && self.po.statements.count == 1 && self.type == 'GeneralStatement' 
            unless self.po.found.blank?
                initiator = Participant.find(self.po.found.to_i)
                if initiator
                    founder_statement = Statement.create(type: "AssociateStatement", po_id: self.po.id, total: percentage_amount(self.subtotal.to_d, self.po.founder_percentage), company_name: Company.first.company_name, company_address: Company.first.address, participant_name: initiator.name, participant_address: initiator.address, invoice_number: 'REQ-' + self.po.po_number.to_s + '-F', percentage: Company.first.company_options[:business_finder], issued_to: initiator.id)
                    self.line_items.each do |item|
                        LineItem.create(statement_id: founder_statement.id, type: item.type, title: item.title, description: item.description, cost: item.cost, taxable: item.taxable, expense_exempt_from_tax: item.expense_exempt_from_tax, expense_cost: item.expense_cost)
                        if item.discounts.any?
                            item.discounts.each do |discount|
                                Discount.create(amount: discount.amount, amount_type: discount.amount_type, line_item_id: discount.line_item_id)
                            end
                        end
                    end
                    StatementNote.create(statement_id: founder_statement.id, notes: Company.first.default_associate_note, terms: Company.first.default_associate_terms)
                    founder_statement.send_out_statement
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
                    associate_statement = Statement.create(type: "AssociateStatement", po_id: self.po.id, total: total, participant_name: usr.name, participant_address: usr.address, company_name: Company.first.company_name, company_address: Company.first.address, invoice_number: 'REQ-' + self.po.po_number.to_s + '-P-' + usr.id.to_s, issued_to: usr.id, percentage: (Company.first.company_options[:associate_percentage]/number_participating_associates))
                    self.line_items.each do |item|
                        LineItem.create(statement_id: associate_statement.id, type: item.type, title: item.title, description: item.description, cost: item.cost, taxable: item.taxable, expense_exempt_from_tax: item.expense_exempt_from_tax, expense_cost: item.expense_cost)
                        if item.discounts.any?
                            item.discounts.each do |discount|
                                Discount.create(amount: discount.amount, amount_type: discount.amount_type, line_item_id: discount.line_item_id)
                            end
                        end
                    end
                    StatementNote.create(statement_id: associate_statement.id, notes: Company.first.default_associate_note, terms: Company.first.default_associate_terms)
                end
            end
            rs_total = (percentage_amount(self.subtotal.to_d, self.po.revenue_share) - expenses)
            Participant.where(revenue_share: true).all.each do |participant|
                share_statement = Statement.create(type: "AssociateStatement", po_id: self.po.id, total: rs_total, participant_name: participant.name, participant_address: participant.address, company_name: Company.first.company_name, company_address: Company.first.address, invoice_number: 'REQ-' + self.po.po_number.to_s + '-RS-' + participant.id.to_s, percentage: Company.first.company_options[:revenue_share], issued_to: participant.id)
                self.line_items.each do |item|
                    LineItem.create(statement_id: share_statement.id, type: item.type, title: item.title, description: item.description, cost: item.cost, taxable: item.taxable, expense_exempt_from_tax: item.expense_exempt_from_tax, expense_cost: item.expense_cost)
                    if item.discounts.any?
                        item.discounts.each do |discount|
                            Discount.create(amount: discount.amount, amount_type: discount.amount_type, line_item_id: discount.line_item_id)
                        end
                    end
                end
                StatementNote.create(statement_id: share_statement.id, notes: Company.first.default_associate_note, terms: Company.first.default_associate_terms)
            end
        else
            errors.add :statement, 'needs Initiator to proceed.'
        end
        if ass_users.count > 0 && self.po.statements.all.where(type: 'AssociateStatement').count >= 1
            self.po.update(status: 'Associate Submitted')
            self.update(status_code: 'A')
        end
    end

    def generate_client_statement
        if ass_users.count > 0 && self.po.statements.all.where(type: 'ClientStatement').count <= 0
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

    def kind?
        if self.client
            return "Invoice"
        else
            return "Invoice Request"
        end
    end

    def next
        Statement.where(po_id: self.po.id).where.not(type: "GeneralStatement").where("id > ?", id).order(id: :asc).limit(1).first
      end
    
      def prev
        Statement.where(po_id: self.po.id).where.not(type: "GeneralStatement").where("id < ?", id).order(id: :desc).limit(1).first
      end
end
