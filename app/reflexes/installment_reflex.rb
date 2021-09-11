# frozen_string_literal: true

class InstallmentReflex < ApplicationReflex

  def check_string(string)
    string.scan(/\D/).empty?
  end

  def percentage_ceiling(string)
    total = 0
    array = string.split(" ").map(&:to_i) 
    array.each do |number| 
      n = number.to_i 
      total = total + n
    end
    if total == 100
      return true
    end
  end

  def change
    po = Po.friendly.find(element.dataset[:id])
    installments = element.dataset[:installments]
    if installments == "100"
      po.installments.destroy_all
      portion = Installment.new(po_id: po.id, percentage: 100) 
      portion.save 
      po.number_of_installments = 1
      po.save
    elsif (! check_string(installments)) && percentage_ceiling(installments)
        po.installments.destroy_all
        new_installments_count = []
        installments.split(" ").each do |installment| 
          portion = Installment.new(po_id: po.id, percentage: installment) 
          portion.save 
          new_installments_count << 1
        end
        po.number_of_installments = new_installments_count.length
        po.save
        flash.notice = 'Installments adjusted please add due dates'
    end
  end
end