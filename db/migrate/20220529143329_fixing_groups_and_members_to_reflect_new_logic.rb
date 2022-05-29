class FixingGroupsAndMembersToReflectNewLogic < ActiveRecord::Migration[6.1]
  def change
    remove_column :groups, :bill_to, :integer
    add_column :groups, :ruser_id, :integer
    add_index :groups, :ruser_id
    remove_column :members, :po_user, :integer
    add_column :members, :client, :integer
    add_index :members, :client
  end
end
