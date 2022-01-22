class AddIssuedToToStatements < ActiveRecord::Migration[6.1]
  def change
    add_column :statements, :issued_to, :integer
  end
end
