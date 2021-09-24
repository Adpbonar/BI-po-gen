class AssociateStatement < Statement 
    validates :country_code, presence: true
    
    def total
        cost = 0.0
        self.service_items.each do |item|
            cost = cost + item.cost
        end
        return cost
    end
end
