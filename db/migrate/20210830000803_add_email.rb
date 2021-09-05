class AddEmail < ActiveRecord::Migration[6.1]
  def change
    # encrypted data
    add_column :participants, :emailaddress_ciphertext, :text
    add_column :participants, :name_ciphertext, :text
    add_column :participants, :phone_ciphertext, :text
    add_column :participants, :pos_ciphertext, :text
    add_column :participants, :address_ciphertext, :text
    # add_column :participants, :type_ciphertext, :text
    

    # blind index
    add_column :participants, :emailaddress_bidx, :string
    add_index :participants, :emailaddress_bidx, unique: true
    add_column :participants, :name_bidx, :string
    add_index :participants, :name_bidx, unique: true
    add_column :participants, :phone_bidx, :string
    add_index :participants, :phone_bidx, unique: true
    add_column :participants, :po_bidx, :string
    add_index :participants, :po_bidx, unique: true
    add_column :participants, :address_bidx, :string
    add_index :participants, :address_bidx, unique: true

    # drop original here unless we have existing users
    remove_column :participants, :email
    remove_column :participants, :name
    remove_column :participants, :pos
    remove_column :participants, :address
  end
end
