class Detail < ApplicationRecord
    belongs_to :line_item

    validates :title, presence: true
    validates :hours, presence: true
    validates :hours, numericality: { greater_than_or_equal_to: 1 }
end
