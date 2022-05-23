class Ruser < ApplicationRecord
  belongs_to :po

  def party
    Participant.find(self.participant_id).name
  end
end
