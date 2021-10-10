class Group < ApplicationRecord
    belongs_to :po
    has_many :members
end
