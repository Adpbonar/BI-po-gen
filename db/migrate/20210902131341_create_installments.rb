class CreateInstallments < ActiveRecord::Migration[6.1]
  def change
    create_table :installments do |t|
      t.integer :percentage
      t.datetime :due_date
      t.references :po, null: false, foreign_key: true

      t.timestamps
    end
  end
end
