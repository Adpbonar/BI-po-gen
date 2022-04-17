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

   def tax
     return adjusted_total.split(":").last.to_f + (service_tax + expense_tax) 
   end
  
end