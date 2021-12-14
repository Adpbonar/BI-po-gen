module PosHelper

    def type_switch(record)
        if record == 'Associate'
            return 'Client'
        else
            return 'Associate'
        end
    end

end
