class CreateRusers < ActiveRecord::Migration[6.1]
  def change
    create_table :rusers do |t|
      t.integer :po_id
      t.integer :participant_id
      t.timestamps
    end
  end
end
