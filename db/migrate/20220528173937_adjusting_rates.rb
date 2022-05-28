class AdjustingRates < ActiveRecord::Migration[6.1]
  def change
    remove_column :rates, :hours, :integer
    add_column :rates, :session_length, :float
    add_column :rates, :session_count, :integer
  end
end
