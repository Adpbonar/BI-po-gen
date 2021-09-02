class CreateLineItems < ActiveRecord::Migration[6.1]
  def change
    create_table :line_items do |t|
      t.references :statement
      t.string :title
      t.text :description
      t.float :cost
      t.boolean :taxable, :default => true

      t.timestamps
    end
  end
end
