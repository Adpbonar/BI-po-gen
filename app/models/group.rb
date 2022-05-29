class Group < ApplicationRecord
    belongs_to :ruser
    has_many :members
end
