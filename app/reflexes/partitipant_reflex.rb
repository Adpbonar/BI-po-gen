class PartitipantReflex  < ApplicationReflex

    def add
        participant = Participant.find(element.dataset[:id])
        po = Po.find(element.dataset[:po])
        user = PoUser.create(po_id: po.id, participant_id: participant.id)
        if user.valid?
            user.save
        end
        morph :nothing
    end

    def show
        po = Po.find(element.dataset[:id])
        if po.valid?
            po.update(show_participant: true)
        end
    end

    def hide
        po = Po.find(element.dataset[:id])
        if po.valid?
            po.update(show_participant: false)
        end
    end

    def coordinator
        po = Po.find(element.dataset[:id])
        participant = Participant.find(element.dataset[:coordinator])
        if participant.type == 'Associate' && po.learning_coordinator.blank? && participant.valid? && po.valid?
            po.update(learning_coordinator: participant.id)
        end
    end

    def remove_coordinator
        po = Po.find(element.dataset[:id])
        unless po.learning_coordinator.blank? && participant.valid? && po.valid?
            po.update(learning_coordinator: nil)
        end
          
    end

    def initiator
        po = Po.find(element.dataset[:id])
        participant = Participant.find(element.dataset[:coordinator])
        if participant.type == 'Associate' && po.found.blank? && participant.valid? && po.valid?
            po.update(found: participant.id)
        end
    end

    def remove_initiator
        po = Po.find(element.dataset[:id])
        unless po.found.blank? && participant.valid? && po.valid?
            po.update(found: nil)
        end
    end
end