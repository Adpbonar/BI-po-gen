class CreatePayments < ActiveRecord::Migration[6.1]
  def change
    create_table :payments do |t|
      t.decimal :expected_amount, precision: 5, scale: 2
      t.decimal :amount_received, precision: 5, scale: 2
      t.string :reference_number

      t.timestamps
    end
  end
end
