class CreateRankingForms < ActiveRecord::Migration[6.1]
  def change
    create_table :ranking_forms do |t|
      t.string :name
      t.integer :ranking
      t.text :participants
      t.text :profile
      t.string :profile_name

      t.timestamps
    end
    add_column :participants, :image_link, :text
  end
end
