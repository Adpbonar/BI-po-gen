class Group < ApplicationRecord
    has_many :members

    def leader
        Participant.find(self.ruser_id).name
    end

    def email
        Participant.find(self.ruser_id).emailaddress
    end
end
