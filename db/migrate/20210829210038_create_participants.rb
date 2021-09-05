class CreateParticipants < ActiveRecord::Migration[6.1]
  def change
    create_table :participants do |t|
      t.string :email
      t.string :name
      t.string :address
      t.text :pos
      t.string :type
      t.integer :profit_share

      t.timestamps
    end
  end
end
