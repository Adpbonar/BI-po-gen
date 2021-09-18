# frozen_string_literal: true

class ItemReflex < ApplicationReflex
  def remove
    item = LineItem.find(element.dataset[:id])
    item.destroy
  end
end