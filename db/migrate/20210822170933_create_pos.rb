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
      t.float :po_amount
      t.float :amount_owed
      t.float :amount_paid
      t.boolean :taxable, :defaut =>  true
      t.string :issued_to
      t.string :company_name
      t.string :learning_coordinator
      t.string :coachee_name
      t.string :approved_by
      t.integer :associate_percentage
      t.integer :status

      t.timestamps
    end
  end
end
