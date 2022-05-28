class AddTimeTableToRates < ActiveRecord::Migration[6.1]
  def change
    add_column :rates, :status, :string
    add_index :rates, :status
  end
end
