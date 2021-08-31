class Po < ApplicationRecord
    has_many :statements
    belongs_to :user

    extend FriendlyId
    friendly_id :po_number, use: :slugged

    # Set the po number
    def set_po_number
        last_po = Po.last
        unless last_po == nil
            return last_po.po_number + 1
        else
            return 1001
        end
    end
end
