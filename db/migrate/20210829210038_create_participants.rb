class CreateParticipants < ActiveRecord::Migration[6.1]
  def change
    create_table :participants do |t|
      t.string :email
      t.string :name
      t.string :address
      t.text :pos
      t.string :type
      t.boolean :revinue_share, :default => false
      t.decimal :tax_rate, precision: 5, scale: 2

      t.timestamps
    end
  end
end
