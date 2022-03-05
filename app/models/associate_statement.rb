class AssociateStatement < Statement 
    def self.model_name
        Statement.model_name
    end
    
    def staff_total
        cost = 0.0
        self.service_items.each do |item|
            cost = cost + item.cost
        end
        self.expense_items.each do |item|
            cost = cost + item.cost
        end
        return cost
   end

    def adjusted_total 
        cost = 0
        party = Participant.find(self.issued_to)
        self.adjustments.map do |adj|
            if adj.absolute == true
                amount = adj.cost
            else
                amount = ("-" + adj.cost.to_s).to_f
            end
            if adj.taxed
                cost =  cost + percentage_amount(amount, party.tax_rate)
            else
                cost = cost + amount
            end
        end
        return self.total + cost
    end

end