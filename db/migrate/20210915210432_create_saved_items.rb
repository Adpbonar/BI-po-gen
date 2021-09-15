class CreateSavedItems < ActiveRecord::Migration[6.1]
  def change
    create_table :saved_items do |t|
      t.string :title
      t.text :description
      t.decimal :cost
      t.string :type

      t.timestamps
    end
  end
end
