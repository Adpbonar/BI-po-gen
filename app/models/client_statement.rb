class ClientStatement < Statement 
  def formula
    cost = 0.0
    self.po.installments.each { |installment| cost = cost + installment.cost }
    return cost
  end

  def no_discount_cost
    cost = 0.0
    self.line_items.all.each do |item|
      cost = cost + item.cost
    end
    return cost
  end

  def total_discounts
    cost = 0.0
    self.line_items.all.each do |item|
      item.discounts.each do |off|
        if off.amount_type == 1
            cost = cost + off.amount.to_f 
        elsif off.amount_type == 0
            cost = cost + (item.cost * ("0." + (off.amount).to_s).to_f)
        end
      end
    end
    cost.to_f
  end

  def item_discounts(item)
    if item.type == 'ServiceItem'
      discounted_item = LineItem.find(item.id)
      if discounted_item.discounts.any?
        if discounted_item.discounts.count == 1
          return '<div class="discount-applied">Discount Applied</div>'
        else
          return '<div class="discount-applied">Discounts Applied</div>'
        end
      end
    end
  end
end
