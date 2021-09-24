class CreateDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :details do |t|
      t.string :title
      t.text :description
      t.float :hours
      t.string :completed_by

      t.timestamps
    end
  end
end
