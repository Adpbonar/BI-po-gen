class AssociateStatement < Statement 
   
    
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
end
