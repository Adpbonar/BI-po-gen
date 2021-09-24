class Participant < ApplicationRecord
    
    has_many :po_users

    encrypts :emailaddress, :name, :phone, :address
    encrypts :pos, type: :array
    blind_index :emailaddress, :name, :phone, :address, :pos
    validates :type, presence: true
    validates :emailaddress, presence: true
    validates :address, presence: true
    validates :phone, presence: true
    validates :country_code, presence: true
    
    broadcasts

    def is_euro?
        eu = ["AT", "BE", "CY", "DE", "EE", "IE", "EL", "ES", "FR", "FI", "IT", "MT", "LV", "LT", "LU", "NL", "PT", "SK", "SI"]
        if eu.include?(self.country_code)
            return true
        end
    end

    def type_of
        self.type
    end

    def set_currency
        if self.is_euro?
            return 'EU'
        elsif self.country_code == "CA"
            return "CA"
        elsif self.country_code == "GB"
            return "LB"
        else
            return "US"
        end
    end

    def set_po_currency
        
    end
end