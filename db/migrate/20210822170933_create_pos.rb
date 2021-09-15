class CreatePos < ActiveRecord::Migration[6.1]
  def change
    create_table :pos do |t|
      t.references :user
      t.string :title
      t.text :description
      t.datetime :start_date
      t.datetime :end_date
      t.integer :po_number
      t.string :service_type
      t.integer :number_of_installments
      t.string :tax_amount
      t.string :issued_to
      t.string :company_name
      t.integer :learning_coordinator
      t.string :approved_by
      t.integer :associate_percentage
      t.integer :founder_percentage
      t.float :revenue_share
      t.string :status
      t.string :currency

      t.timestamps
    end
    add_index :pos, :po_number, unique: true
  end
end
