class AddPoUsersToItems < ActiveRecord::Migration[6.1]
  def change
    add_column :po_users, :items, :text
    add_index :po_users, :items
  end
end
