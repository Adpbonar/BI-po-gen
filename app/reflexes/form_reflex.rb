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
        unless ranking.any? || form.rankings.where(rank: rank).any?
            r = Ranking.new(ranking_form_id: form.id, rank: rank, participant_id: participant.id)
            r.save
            if form.rankings.count == Po.where(po_number: form.po_number).first.rusers.count
                form.update(complete: true)
            else
                form.update(complete: false)
            end
            if form.complete
                form.update(ranking: form.rankings.order(:rank).first.participant.id)
            else
                form.update(ranking: nil)
            end
        else
            ranking.destroy_all
        end
    end

    def sort
        po = Po.find(element.dataset[:id])
        po.update(accepting_submissions: false)
        po.process_form_data if RankingForm.where(po_number: po.po_number).any?
    end

    def group
        po = Po.find(element.dataset[:id])
        members =  RankingForm.where(po_number: po.po_number)
        members.group_by(&:winner).each do |usr, forms| 
            g = Group.new(po_id: po.id, ruser_id: usr.id)
            if g.save
                forms.each do |form|
                    m = Member.new(group_id: g.id, client: form.id)
                    m.save
                end
            end
        end
    end

end