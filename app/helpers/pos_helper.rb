module PosHelper

    def type_switch(record)
        if record == 'Associate'
            return 'Client'
        else
            return 'Associate'
        end
    end

    def check_for_r_user(po, id)
        unless Ruser.where(po_id: po, participant_id: id).any?
            return true
        end
    end

 

end
