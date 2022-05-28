class AddTimeTableToChargableRates < ActiveRecord::Migration[6.1]
  def change
    add_column :chargable_rates, :status, :string
    add_index :chargable_rates, :status
  end
end
