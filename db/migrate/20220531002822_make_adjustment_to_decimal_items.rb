class MakeAdjustmentToDecimalItems < ActiveRecord::Migration[6.1]
  def change
    change_column :line_items, :cost, :decimal, :precision => 10, :scale => 5
  end
end
