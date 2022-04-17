class PoUser < ApplicationRecord
    belongs_to :po
    belongs_to :participant
    encrypts :learning_coordinator, type: :integer
    encrypts :found, type: :integer
    serialize :items, Array

    def type_of
        self.participant.type
    end
end
