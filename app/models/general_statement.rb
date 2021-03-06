class GeneralStatement < Statement 

    def self.model_name
        Statement.model_name
    end

    def general_cost
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

   

    def tax 
        return service_tax + expense_tax
    end
end
