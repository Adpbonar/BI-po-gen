class AddShowPorgramsToStatements < ActiveRecord::Migration[6.1]
  def change
    add_column :statements, :show_programs, :boolean, :default => false
  end
end
