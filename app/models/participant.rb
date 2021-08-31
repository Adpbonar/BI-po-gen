class Participant < ApplicationRecord
    encrypts :email, :name, :phone, :address, :pos, :type
    blind_index :email, :name, :phone, :address, :pos, :type
    

end