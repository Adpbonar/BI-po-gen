class MakingInstallmentsDecimals12 < ActiveRecord::Migration[6.1]
  def change
    change_column :installments, :percentage, :decimal, :precision => 12, :scale => 9
  end
end
