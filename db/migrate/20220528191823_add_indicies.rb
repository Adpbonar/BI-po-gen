class AddIndicies < ActiveRecord::Migration[6.1]
  def change
    add_index :rates, :title
    add_index :chargable_rates, :title
    add_index :porfessional_rates, :title
  end
end
