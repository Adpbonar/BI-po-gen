# frozen_string_literal: true

class DiscountReflex < ApplicationReflex
  def remove
    item = Discount.find(element.dataset[:id])
    po = item.line_item.statement.po
    unless po.locked
      item.destroy
      po.set_status
    end
  end
end