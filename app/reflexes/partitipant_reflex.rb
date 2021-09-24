class PartitipantReflex  < ApplicationReflex

    def add
        participant = Participant.find(element.dataset[:id])
        po = Po.find(element.dataset[:po])
        user = PoUser.create(po_id: po.id, participant_id: participant.id)
        if user.valid?
            user.save
            flash.alert = 'Participant added to PO'
        else
            flash.alert = 'Participant wasn\'t added to PO'
        end
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
end