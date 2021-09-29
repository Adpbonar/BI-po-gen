class Company < ApplicationRecord
    validates :company_name, presence: true
    validates :address, presence: true
end
