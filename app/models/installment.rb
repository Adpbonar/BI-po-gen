class Installment < ApplicationRecord
    belongs_to :po
    validates :due_date, presence: true, :on => :update
    validates :percentage, presence: true
    validates :percentage, numericality: { in: 1..75 }
    validate :reasonable_installment_due_date
    # validate :due_date_is_valid_datetime


    def reasonable_installment_due_date
        return if self.due_date >= self.po.start_date
        errors.add :due_date, 'must not be before the po start date'
    end

    def due_date_is_valid_datetime
        errors.add(:due_date, 'must be a valid datetime') if ((DateTime.parse(due_date) rescue ArgumentError) == ArgumentError)
      end
end
