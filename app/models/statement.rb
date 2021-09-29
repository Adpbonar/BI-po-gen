class Statement < ApplicationRecord
    belongs_to :po
    has_many :line_items
    has_many :payments
    encrypts :participant_address, :participant_name
        
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
    #     associate_statement = AssociateStatement.new(po_id: self.po.id)
    #     associate_statement.save
    #     client_statement = ClientStatement.where(po_id: associate_statement.po_id)
    #     client_statement.line_items.each do |item|
    #         associate_item.create(statement_id: associate_statement.id, title: item.title, description: item.description, cost: item.cost, taxable: item.taxable)
    #     end
    end
end
