class CreateLineItems < ActiveRecord::Migration[6.1]
  def change
    create_table :line_items do |t|
      t.string :name
      t.references :statement, null: false, foreign_key: true
      t.text :description
      t.float :cost
      t.string :type

      t.timestamps
    end
  end
end
