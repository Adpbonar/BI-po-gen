class AddDetailedToStatements < ActiveRecord::Migration[6.1]
  def change
    add_column :statements, :show_detailed, :boolean, :default => false
  end
end
