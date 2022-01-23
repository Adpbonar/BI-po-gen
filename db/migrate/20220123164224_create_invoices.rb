class CreateInvoices < ActiveRecord::Migration[6.1]
  def change
    create_table :invoices do |t|
      t.integer :po_id
      t.string :name
      t.integer :participant_id
      t.text :description
      t.float :tax_rate
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    remove_column :pos, :show_participant
    remove_column :statements, :show_programs
  end
end
