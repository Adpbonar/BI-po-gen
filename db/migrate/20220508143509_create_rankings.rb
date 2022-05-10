class CreateRankings < ActiveRecord::Migration[6.1]
  def change
    create_table :rankings do |t|
      t.integer :ranking
      t.string :participant_id
      t.integer :ramking_form_id

      t.timestamps
    end
  end
end
