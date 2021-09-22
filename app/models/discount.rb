class Discount < ApplicationRecord
  belongs_to :line_item
  validate :reasonable_amount_off
  validates :amount_type, presence: true
  validate :discount_type
  validates :amount, presence: true
  validates :amount, numericality: { greater_than_or_equal_to: 1 }

  broadcasts

  def reasonable_amount_off
    if self.amount.to_i > 0
      discount_amount = self.amount.to_f
      total = self.line_item.cost
      if self.amount_type == 0
        return if discount_amount <= 75.0
        errors.add :amount, 'is too high. The maximum is 75%. Try a lower percentage.'
      end
      if self.amount_type == 1
        return unless discount_amount.to_i >= total.to_i
        errors.add :amount, 'is too high. Freebies must be done in mutiple discounts.'
      end
    end
  end

  def discount_type
    return if (amount_type > -1 && amount_type < 2) || self.line_item.type != 'ServiceItem'
    errors.add :discount_type, 'is not valid'
  end

  TYPE = {
        'Amount': '1',
        'Percentage': '0',
    }
end
