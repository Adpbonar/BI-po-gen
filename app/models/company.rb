class Company < ApplicationRecord
    validates :company_name, presence: true
    validates :address, presence: true
    validates :company_options, presence: true
    serialize :company_options, Hash
    validate :options_length

    def options_length
        if company_options.values.length != 7
            errors.add :company_options, 'not set.'
        end
    end
end
