class Installment < ApplicationRecord
    belongs_to :po
    
    def reasonable_installment_due_date
        return if self.due_date < self.po.start_date
        errors.add :due_date, 'must not be before the po start date'
    end
end
