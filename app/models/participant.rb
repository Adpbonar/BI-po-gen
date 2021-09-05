class Participant < ApplicationRecord
    encrypts :emailaddress, :name, :phone, :address, :pos
    blind_index :emailaddress, :name, :phone, :address, :pos
end