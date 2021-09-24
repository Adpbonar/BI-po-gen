class PoUser < ApplicationRecord
    belongs_to :po
    belongs_to :participant

    def type_of
        self.participant.type
    end
end
