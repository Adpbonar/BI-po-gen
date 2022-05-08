class LineItem < ApplicationRecord
    require 'bigdecimal'
    belongs_to :statement
    has_many :discounts
    has_many :details

    validates :title, presence: true
    validates_length_of :title, in: 1..100
    validates :cost, presence: true
    validates :type, presence: true
    validates :cost, numericality: { greater_than_or_equal_to: 0 }
    validates_length_of :description, in: 0..350

    broadcasts

    def calculate_discounts
        cost = self.cost.to_f
        total = 0.to_d
        self.discounts.order(:id).each do |off|
            if off.amount_type == 1
                total = total + off.amount.to_f 
            elsif off.amount_type == 0
                total = total + (cost * ("0." + (off.amount).to_s).to_f)
            end
        end
        item_cost = (cost - total).to_s
        if cost.to_i <= total.to_i || (item_cost.length == 3 && item_cost == "0.0")
            return "Free"
        else 
            return item_cost.to_f
        end
    end

    def saved_item_check
        unless SavedItem.where(title: self.title, type: 'Saved' + self.type.split("I").first).any?
            return true
        end
    end

    TYPE = {
        'Expense': 'ExpenseItem',
        'Service': 'ServiceItem',
    }
end
