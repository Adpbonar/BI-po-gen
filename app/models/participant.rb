class Participant < ApplicationRecord
    encrypts :emailaddress, :name, :phone, :address, :pos
    blind_index :emailaddress, :name, :phone, :address, :pos

    def is_euro?
        eu = ["AT", "BE", "CY", "DE", "EE", "IE", "EL", "ES", "FR", "FI", "IT", "MT", "LV", "LT", "LU", "NL", "PT", "SK", "SI"]
        if eu.include?(self.country_code)
            return true
        end
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