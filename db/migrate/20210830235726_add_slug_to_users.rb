class AddSlugToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :pos, :slug, :string
    add_index :pos, :slug, unique: true
  end
end
