class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.string :title
      t.text :description
      t.float :cost
      t.boolean :taxable, default: false
      t.references :invoice, null: false, foreign_key: true

      t.timestamps
    end
    add_column :invoices, :terms, :text
    add_column :invoices, :notes, :text
    add_column :statements, :versions, :text
  end
end
