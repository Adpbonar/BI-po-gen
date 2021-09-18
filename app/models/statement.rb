class Statement < ApplicationRecord
    belongs_to :po
    has_many :line_items
    has_many :payments
        

    def total
        cost = 0.0
        self.po.installments.map { |installment| cost = cost + installment.cost }
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
