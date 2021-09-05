class CreateLineItems < ActiveRecord::Migration[6.1]
  def change
    create_table :line_items do |t|
      t.references :statement
      t.string :title
      t.text :description
      t.decimal :cost, precision: 5, scale: 2
      t.boolean :taxable, :default => true
      t.string :type

      t.timestamps
    end
  end
end
