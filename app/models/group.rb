class Group < ApplicationRecord
    has_many :members

    def leader
        Participant.find(self.ruser_id)
    end

    def leader_id
        self.ruser_id
    end

    def name
        self.leader.name
    end

    def email
        self.leader.emailaddress
    end

end
