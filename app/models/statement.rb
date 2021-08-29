class Statement < ApplicationRecord
  belongs_to :po
  has_many :line_items
end
