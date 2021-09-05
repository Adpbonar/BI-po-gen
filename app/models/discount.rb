class Discount < ApplicationRecord
  belongs_to :line_item

  TYPE = {
        'Amount': 'amount',
        'Percentage': 'percent',
    }
end
