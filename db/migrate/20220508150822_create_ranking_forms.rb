class CreateRankingForms < ActiveRecord::Migration[6.1]
  def change
    create_table :ranking_forms do |t|
      t.string :name
      t.references :ranking, null: false, foreign_key: true
      t.integer :ranking
      t.text :participants,

      t.timestamps
    end
  end
end
