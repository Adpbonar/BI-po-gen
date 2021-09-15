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
      portion = Installment.new(po_id: po.id, percentage: 100, due_date: po.start_date) 
      portion.save 
      po.number_of_installments = 1
      po.save
      flash.alert = 'Installments adjusted please add due dates'
    elsif (! check_string(installments)) && percentage_ceiling(installments)
      po.installments.destroy_all
      date_collector = []
      multiple_installments = installments.split(" ")
      num = (multiple_installments.length + 1) -2
      date = ((po.end_date.to_i - po.start_date.to_i) / num).round.abs
      multiple_installments.each_with_index do |installment, i| 
        if i == 0
          portion = Installment.new(po_id: po.id, percentage: installment, due_date: po.start_date)
        else
          new_due_date = date_collector[-1] + date
          portion = Installment.new(po_id: po.id, percentage: installment, due_date: new_due_date)
        end
          portion.save 
          date_collector << portion.due_date
        end
      po.number_of_installments = date_collector.length
      po.save
      flash.alert = 'Installments adjusted please add due dates'
    else
      flash.alert = 'Installment could not be saved. Please refer to the pattern below the form. Remember that decimals are not accepted and that the total of the installments must equal 100.'
    end
  end
end