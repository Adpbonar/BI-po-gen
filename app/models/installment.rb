class Installment < ApplicationRecord
    belongs_to :po
    # validates_inclusion_of :percentage, :in => 1..100
    # validates :due_date, presence: true
end
