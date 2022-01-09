class Company < ApplicationRecord
    validates :company_name, presence: true
    validates :address, presence: true
    validates :company_options, presence: true
    serialize :company_options, Hash
    validate :options_length
    validates :default_client_note, presence: true
    validates :default_associate_note, presence: true
    validates :default_client_terms, presence: true
    validates :default_associate_terms, presence: true
    validates_length_of :default_client_note, in: 1..500
    validates_length_of :default_associate_note, in: 1..500
    validates_length_of :default_client_terms, in: 1..500
    validates_length_of :default_associate_terms, in: 1..500

    def options_length
        if company_options.values.length != 7
            errors.add :company_options, 'not set.'
        end
    end
end
