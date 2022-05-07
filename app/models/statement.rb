class Statement < ApplicationRecord
   
    belongs_to :po
    has_many :line_items
    has_many :payments
    has_many :adjustments
    has_one :statement_note

    encrypts :participant_address, :participant_name
    encrypts :statement_participant, type: :integer

    validates :status_code, length: {is: 1}, allow_blank: true
    # validate :valid_general

    require 'bigdecimal'

    def valid_float?
        true if Float self rescue false
      end

    def valid_general
        unless self.type == "GeneralStatement" || self.type ==  "AssociateStatement"
            if (currency.blank? || (tax_rate.blank? || (Float(tax_rate) == nil) || (! tax_rate.to_s.valid_float?)))
                errors.add :statement, 'is not valid'
            end 
        end
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

    def send_out_statement
        StatementMailer.pdf_attachment(self).deliver 
    end

    def set_invoice_number
        last_invoice = Statement.where(type: "ClientStatement").last
        unless last_invoice == nil
            last_number = (last_invoice.invoice_number.split("-").last.to_i + 1).to_s
            return "INV." + last_number.to_s
        else
            return "INV." + self.po.po_number.to_s + DateTime.current.strftime("%y").to_s + "10"
        end
    end

    def generate_client_statement
        customers = self.po.po_users.all
        associates = []
        customers.all.each { |user| associates << user if user.participant.type == "Associate" }
        if associates.count > 0
            customers.each do |user|
                usr = user.participant
                if usr.type == 'Client'
                    number = self.set_invoice_number.split(".")
                    client_statement = ClientStatement.create(po_id: self.po.id, total: self.subtotal, participant_name: usr.name, participant_address: usr.address, company_name: Company.first.company_name, company_address: Company.first.address, invoice_number: number.first.to_s + "-" + usr.id.to_s + number.last.to_s, currency: usr.currency, tax_rate: usr.tax_rate, issued_to: usr.id)
                    if client_statement.save
                        self.line_items.each do |item|
                            line = LineItem.create(statement_id: client_statement.id, type: item.type, title: item.title, description: item.description, cost: item.cost, taxable: item.taxable, expense_exempt_from_tax: item.expense_exempt_from_tax, expense_cost: item.expense_cost)
                            if item.discounts.any?
                                item.discounts.each do |discount|
                                    Discount.create(amount: discount.amount, amount_type: discount.amount_type, line_item_id: line.id)
                                end
                            end
                        end
                        StatementNote.create(statement_id: client_statement.id, notes: Company.first.default_client_note, terms: Company.first.default_client_terms)
                    end
                end
            end 
            if  self.po.statements.all.where(type: 'AssociateStatement').count >= 1 && self.po.statements.all.where(type: 'ClientStatement').count >= 1 
                self.po.set_status
                self.update(achieved: true)
            end
        else
            errors.add :associates, 'must be present'
        end
    end

    def generate_associate_statement
        ass_users = self.po.po_users.all
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
   
        PoUser.destroy_duplicates_by(:participant_id, :po_id)
        clients = []
        ass_users.each { |user| clients << user if user.participant.type == "Client" }
        if clients.count > 0
            if self.po.status == 'Prepared' && self.po.statements.count == 1 && self.type == 'GeneralStatement' && self.achieved == false
                unless self.po.found.blank? && self.po.learning_coordinator.blank?
                    initiator = Participant.find(self.po.found.to_i)
                    if initiator
                        founder_statement = AssociateStatement.create(po_id: self.po.id, total: percentage_amount(self.subtotal.to_d, self.po.founder_percentage), company_name: Company.first.company_name, company_address: Company.first.address, participant_name: initiator.name, participant_address: initiator.address, invoice_number: 'REQ-' + self.po.po_number.to_s + '-F', percentage: Company.first.company_options[:business_finder], currency: initiator.currency, tax_rate: initiator.tax_rate, issued_to: initiator.id)
                        if founder_statement.save
                            self.line_items.each do |item|
                                line = LineItem.create(statement_id: founder_statement.id, type: item.type, title: item.title, description: item.description, cost: item.cost, taxable: item.taxable, expense_exempt_from_tax: item.expense_exempt_from_tax, expense_cost: item.expense_cost)
                                if item.discounts.any?
                                    item.discounts.each do |discount|
                                        Discount.create(amount: discount.amount, amount_type: discount.amount_type, line_item_id: line.id)
                                    end
                                end
                            end
                            StatementNote.create(statement_id: founder_statement.id, notes: Company.first.default_associate_note, terms: Company.first.default_associate_terms)
                        end
                    end
                end
                total = (percentage_amount(self.subtotal.to_d, self.po.associate_percentage) - expenses) / ass_users.count
                ass_users.each do |user|
                    usr = user.participant
                    if usr.type == 'Associate'
                        associate_statement = AssociateStatement.create(po_id: self.po.id, total: total, participant_name: usr.name, participant_address: usr.address, company_name: Company.first.company_name, company_address: Company.first.address, invoice_number: 'REQ-' + self.po.po_number.to_s + '-P-' + usr.id.to_s, currency: usr.currency, tax_rate: usr.tax_rate, issued_to: usr.id, percentage: (Company.first.company_options[:associate_percentage]/number_participating_associates))
                        if associate_statement.save
                            self.line_items.each do |item|
                                line = LineItem.create(statement_id: associate_statement.id, type: item.type, title: item.title, description: item.description, cost: item.cost, taxable: item.taxable, expense_exempt_from_tax: item.expense_exempt_from_tax, expense_cost: item.expense_cost)
                                if item.discounts.any?
                                    item.discounts.each do |discount|
                                        Discount.create(amount: discount.amount, amount_type: discount.amount_type, line_item_id: line.id)
                                    end
                                end
                            end
                            StatementNote.create(statement_id: associate_statement.id, notes: Company.first.default_associate_note, terms: Company.first.default_associate_terms)
                        end
                    end
                end 
                rs_total = (percentage_amount(self.subtotal.to_d, self.po.revenue_share) - expenses)
                Participant.where(revenue_share: true).all.each do |participant|
                share_statement = AssociateStatement.create(po_id: self.po.id, total: rs_total, participant_name: participant.name, participant_address: participant.address, company_name: Company.first.company_name, company_address: Company.first.address, invoice_number: 'REQ-' + self.po.po_number.to_s + '-RS-' + participant.id.to_s, percentage: Company.first.company_options[:revenue_share], tax_rate: participant.tax_rate, currency: participant.currency, issued_to: participant.id)
                if share_statement.save
                    self.line_items.each do |item|
                    line = LineItem.create(statement_id: share_statement.id, type: item.type, title: item.title, description: item.description, cost: item.cost, taxable: item.taxable, expense_exempt_from_tax: item.expense_exempt_from_tax, expense_cost: item.expense_cost)
                    if item.discounts.any?
                        item.discounts.each do |discount|
                        Discount.create(amount: discount.amount, amount_type: discount.amount_type, line_item_id: line.id)
                        end
                    end
                    end
                    StatementNote.create(statement_id: share_statement.id, notes: Company.first.default_associate_note, terms: Company.first.default_associate_terms)
                    end
                end
            else
                errors.add :statement, 'needs Initiator to proceed.'
            end
            if ass_users.count > 0 && self.po.statements.all.where(type: 'AssociateStatement').count >= 1
                self.po.update(status: 'Associate Submitted')
                self.generate_client_statement
            end
        else
            errors.add :clients, "must be present"
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

    def invoice_type
        unless self.type == "GeneralStatement"
          if self.client
            return "Client"
          end
          if self.rs
            return "Share"
          end
          if self.founder
            return "Initiator"
          end 
          if ! self.founder || ! self.rs
            return "Associate"
          end
        else
          return "General"
        end
      end

    def next
        Statement.where(po_id: self.po.id).where.not(achieved: true, type: "GeneralStatement").where("id > ?", id).order(id: :asc).limit(1).first
      end
    
      def prev
        Statement.where(po_id: self.po.id).where.not(achieved: true, type: "GeneralStatement").where("id < ?", id).order(id: :desc).limit(1).first
      end

      def expense_tax
        cost = 0
        self.line_items.where(type: 'ExpenseItem').map do |expense| 
          unless expense.expense_exempt_from_tax
              cost = cost + percentage_amount(expense.cost, expense.statement.po.tax_amount) 
          end
      end
      return cost
    end

    def service_tax
      tax = 0
      self.line_items.where(type: 'ServiceItem').map do |service| 
          if service.taxable
              unless service.calculate_discounts == "Free"
                  tax = tax + percentage_amount(service.calculate_discounts, service.statement.po.tax_amount)
              end
          end
      end
      return tax
    end

  def adjusted_total 
    cost = 0
    tax = 0
    party = Participant.find(self.issued_to)
    self.adjustments.map do |adj|
        if adj.absolute == true
            amount = adj.cost
        else
            amount = ("-" + adj.cost.to_s).to_f
        end
        if adj.taxed
            cost =  cost + percentage_amount(amount, party.tax_rate)
            tax = tax + percentage_amount(amount, party.tax_rate)
        else
            cost = cost + amount
        end
    end
    return (self.total + cost).to_s + ":" + tax.to_s
  end
end
