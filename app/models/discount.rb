class Discount < ApplicationRecord
  belongs_to :line_item
  validate :reasonable_amount_off
  validates :amount_type, presence: true
  validates :amount, presence: true
  validates :amount, numericality: { greater_than_or_equal_to: 0 }

  broadcasts

  def reasonable_amount_off
    if self.amount.to_i > 0
      discount_amount = self.amount.to_f
      total = self.line_item.cost
      if self.amount_type == 0
        return if discount_amount <= 75.0
        errors.add :amount, 'is too high.'
      elsif self.amount_type == 1
        return unless discount_amount.to_i > total.to_i
        errors.add :amount, 'is too high.'
      end
    else
      errors.add :amount, 'can\'t be blank'
    end
  end

  TYPE = {
        'Amount': '1',
        'Percentage': '0',
    }
end
