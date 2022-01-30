class AddTaxRateToStatement < ActiveRecord::Migration[6.1]
  def change
    add_column :statements, :tax_rate, :float
  end
end
