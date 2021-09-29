module PosHelper
    def initiator(p)
        initiator = p.split(" ")
        array = []
        1.times do 
        party = initiator.delete_at(-1)
        end
        return initiator.join(" ").split(".").last.split(" ").first
    end

end
