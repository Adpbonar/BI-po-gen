class AddArchivedToStatements < ActiveRecord::Migration[6.1]
  def change
    add_column :statements, :achieved, :boolean, :default => false
    add_index :statements, :achieved
  end
end
