class CreateChargableRates < ActiveRecord::Migration[6.1]
  def change
    create_table :chargable_rates do |t|
      t.string :title
      t.references :company
      t.decimal :rate, :precision => 12, :scale => 9
      t.references :item

      t.timestamps
    end
  end
end
