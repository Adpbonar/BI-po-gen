class ClientStatement < Statement 
  def formula
    cost = 0.0
    self.po.installments.each { |installment| cost = cost + installment.cost }
    return cost
  end
end
