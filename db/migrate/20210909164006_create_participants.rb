class CreateParticipants < ActiveRecord::Migration[6.1]
  def change
    create_table :participants do |t|
      t.string :type
      t.boolean :revenue_share, :default => false
      t.decimal :tax_rate, percision: 5
      
      t.timestamps
    end
    add_column :participants, :emailaddress_ciphertext, :text
    add_column :participants, :name_ciphertext, :text
    add_column :participants, :phone_ciphertext, :text
    add_column :participants, :address_ciphertext, :text
    
    

    # blind index
    add_column :participants, :emailaddress_bidx, :string
    add_index :participants, :emailaddress_bidx, unique: true
    add_column :participants, :name_bidx, :string
    add_index :participants, :name_bidx, unique: true
    add_column :participants, :phone_bidx, :string
    add_index :participants, :phone_bidx, unique: true
    add_column :participants, :address_bidx, :string
    add_index :participants, :address_bidx, unique: true
  end
end
