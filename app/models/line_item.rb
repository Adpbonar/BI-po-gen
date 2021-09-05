class LineItem < ApplicationRecord
    belongs_to :statement
    validates :type, presence: true
    validates :cost, numericality: { greater_than_or_equal_to: 0 },
    format: { with: /\A\d{1,3}(\.\d{1,2})?\z/ }

    TYPE = {
        'Expense': 'ExpenseItem',
        'Service': 'ServiceItem',
    }
end
