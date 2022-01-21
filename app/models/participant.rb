class Participant < ApplicationRecord
    has_many :po_users
    # validates :phone,:presence => true,
    #              :numericality => true,
    #              :length => { :minimum => 10, :maximum => 15 }
    # validates :emailaddress, presence: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, message: 'must be a valid format' } 

    encrypts :emailaddress, :name, :address, :zip, :state, :city, :title, :company
    encrypts :phone, type: :integer

    
   

    # blind_index :emailaddress, :name, :phone, :address, :address, :zip, :state, :city, :title, :company
    validates :type, presence: true
    validates :emailaddress, presence: true
    # validates :address, presence: true
    # validates :phone, presence: true
    # validates :country_code, presence: true
    

    def is_euro?
        eu = ["AT", "BE", "CY", "DE", "EE", "IE", "EL", "ES", "FR", "FI", "IT", "MT", "LV", "LT", "LU", "NL", "PT", "SK", "SI"]
        if eu.include?(self.country_code)
            return true
        end
    end

    def type_of
        self.type
    end


    def member_name
        initiator = self.name.split(" ")
        return initiator.join(" ").split(".").last.split(" ").first
    end


    def first_letter
        self.member_name.split("").first.upcase
    end

    def set_currency
        if self.is_euro?
            return 'EU'
        elsif self.country_code == "CA"
            return 'CA'
        elsif self.country_code == "GB"
            return 'LB'
        else
            return 'US'
        end
    end

    def set_po_currency
        
    end   

    
end