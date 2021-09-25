class CreateSavedDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :saved_details do |t|
      t.string :title
      t.text :description
      t.float :hours
      t.string :completed_by
      t.integer :saved_item_id

      t.timestamps
    end
  end
end
