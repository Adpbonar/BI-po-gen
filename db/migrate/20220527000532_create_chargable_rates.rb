class CreateChargableRates < ActiveRecord::Migration[6.1]
  def change
    create_table :chargable_rates do |t|
      t.string :title
      t.references :company
      t.decimal :rate
      t.references :item

      t.timestamps
    end
  end
end
