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
      t.string :issued_to_ciphertext
      t.string :company_name_ciphertext
      t.string :learning_coordinator_ciphertext
      t.string :found_ciphertext
      t.string :approved_by_ciphertext
      t.integer :associate_percentage
      t.integer :founder_percentage
      t.float :revenue_share
      t.string :status
      t.string :currency

      t.timestamps
    end
    add_index :pos, :po_number, unique: true
    add_column :pos, :company_name_bidx, :string
    add_index :pos, :company_name_bidx
    add_column :pos, :issued_to_bidx, :string
    add_index :pos, :issued_to_bidx
    add_column :pos, :found_bidx, :string
    add_index :pos, :found_bidx
  end
end
