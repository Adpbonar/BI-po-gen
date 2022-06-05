class FixRateRates < ActiveRecord::Migration[6.1]
  def change
    change_column :chargable_rates, :rate, :decimal, :precision => 10, :scale => 5
    change_column :rates, :rate, :decimal, :precision => 10, :scale => 5
    change_column :porfessional_rates, :rate, :decimal, :precision => 10, :scale => 5
  end
end
