class SavedItem < ApplicationRecord
    validates :title, presence: true
    validates_length_of :title, in: 1..100
    validates :cost, presence: true
    validates :type, presence: true
    validates :cost, numericality: { greater_than_or_equal_to: 0 }
    validates_length_of :description, in: 0..350

    def type_of
        self.type.split("d").last
    end
end
