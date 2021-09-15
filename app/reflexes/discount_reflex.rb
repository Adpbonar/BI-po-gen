# frozen_string_literal: true

class DiscountReflex < ApplicationReflex
  def remove
    item = Discount.find(element.dataset[:id])
    item.destroy
  end
end