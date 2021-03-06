class PartitipantReflex  < ApplicationReflex

    def add
        participant = Participant.find(element.dataset[:id])
        po = Po.find(element.dataset[:po])
        unless po.locked
            user = PoUser.create(po_id: po.id, participant_id: participant.id)
            if user.valid?
                user.save
                PoUser.destroy_duplicates_by(:participant_id, :po_id)
            end
            po.set_status
        end
    end

    def remove_participant
        participant = PoUser.find(element.dataset[:id])
        po = Po.find(element.dataset[:po])
        unless po.locked
           participant.destroy
            po.set_status
        end
    end

    def coordinator
        po = Po.find(element.dataset[:id])
        # unless po.locked
        participant = Participant.find(element.dataset[:coordinator])
            if participant.type == 'Associate' && po.learning_coordinator.blank? && po.valid?
                po.update(learning_coordinator: participant.id)
            end
            po.set_status
        # end
    end

    def remove_coordinator
        po = Po.find(element.dataset[:id])
        unless po.locked
            unless po.learning_coordinator.blank? && po.valid?
                po.update(learning_coordinator: nil)
            end
            po.set_status
        end
    end

    def initiator
        po = Po.find(element.dataset[:id])
        unless po.locked
            participant = Participant.find(element.dataset[:coordinator])
            if participant.type == 'Associate' && po.found.blank? && po.valid?
                po.update(found: participant.id)
            end
            po.set_status
        end
    end

    def remove_initiator
        po = Po.find(element.dataset[:id])
        unless po.locked
            unless po.found.blank? && participant.valid? && po.valid?
                po.update(found: nil)
            end
            po.set_status
           
        end
    end
end