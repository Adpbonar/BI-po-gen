class AddPercentageToStatements < ActiveRecord::Migration[6.1]
  def change
    add_column :statements, :percentage, :float
  end
end
