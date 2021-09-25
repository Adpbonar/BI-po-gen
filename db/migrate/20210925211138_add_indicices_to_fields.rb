class AddIndicicesToFields < ActiveRecord::Migration[6.1]
  def change
    add_index :discounts, :amount_type
    add_index :line_items, :type
    add_index :statements, :type
    add_index :details, :line_item_id
    add_index :saved_details, :saved_item_id
    add_index :participants, :type
    add_index :po_users, :po_id
    add_index :po_users, :participant_id
  end
end
