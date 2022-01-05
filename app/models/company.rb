class Company < ApplicationRecord
    validates :company_name, presence: true
    validates :address, presence: true
    validates :company_options, presence: true
    serialize :company_options, Hash
end
