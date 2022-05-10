class FormReflex  < ApplicationReflex

    def add
        po = Po.find(element.dataset[:id])
        participant = Participant.find(element.dataset[:user])
        r = Ruser.new
        r.po_id = po.id
        r.participant_id = participant.id
        r.save
    end

    def remove
        po = Po.find(element.dataset[:id])
        participant = Participant.find(element.dataset[:user])
        Ruser.where(po_id: po.id, participant_id: participant.id).destroy_all
    end

    def select
        participant = Participant.find(element.dataset[:id])
        form = RankingForm.find(element.dataset[:form])
        rank = element.dataset[:rank].to_i
        ranking = form.rankings.where(participant_id: participant.id, rank: rank)
        unless ranking.any?
            r = Ranking.new(ranking_form_id: form.id, rank: rank, participant_id: participant.id)
            r.save
        else
            ranking.destroy_all
        end
    end
end