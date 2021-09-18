class Installment < ApplicationRecord
    belongs_to :po
    validates :due_date, presence: true
    validates :percentage, presence: true
    validates :percentage, numericality: { in: 1..75 }
    validate :reasonable_installment_due_date, :on => :update
    validate :installment_total
    # validate :due_date_is_valid_datetime

    def installment_total
        unless po.status == "New"
            amount = 0
            installments = Installment.all.where(po_id: self.po_id)
            installments.each { |installment| amount = amount + installment.percentage }
            return if amount.to_i < 100
            errors.add :installment_percentages, 'must equal 100'
        end
    end

    # Prevent due_date from being before the PO parent starts
    def reasonable_installment_due_date
        return if self.due_date >= self.po.start_date
        errors.add :due_date, 'must not be before the po start date'
    end

    # Totaling statement line items and costing intallments
    def cost
        cost = 0.0
        items =  self.po.statements.first.line_items.order(:id)
        items.each do |item|
            if item.discounts.any?
                unless item.calculate_discounts == "Free"
                    cost = cost + item.calculate_discounts
                end
            else
                cost = cost + item.cost
            end
        end
        return (cost * ("0." + self.percentage.to_s).to_f).to_d
    end


    # Verify datetime formatting is correct
    def due_date_is_valid_datetime
        errors.add(:due_date, 'must be a valid datetime') if ((DateTime.parse(due_date) rescue ArgumentError) == ArgumentError)
      end
end
