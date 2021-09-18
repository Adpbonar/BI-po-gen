class Statement < ApplicationRecord
    belongs_to :po
    has_many :line_items
    has_many :payments
        
    def percentage_amount(record1, record2)
        return (record1.to_i * ("0." + record2.to_s).to_f)
    end

    def subtotal
        cost = 0.0
        self.po.installments.map { |installment| cost = cost + installment.cost }
        return cost.to_d
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

    def generate_associate_statement
    #     associate_statement = AssociateStatement.new(po_id: self.po.id)
    #     associate_statement.save
    #     client_statement = ClientStatement.where(po_id: associate_statement.po_id)
    #     client_statement.line_items.each do |item|
    #         associate_item.create(statement_id: associate_statement.id, title: item.title, description: item.description, cost: item.cost, taxable: item.taxable)
    #     end
    end
end
