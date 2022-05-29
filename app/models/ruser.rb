class Ruser < ApplicationRecord
  belongs_to :po
  has_many :groups

  def party
    Participant.find(self.participant_id).name
  end
end
