class AddItemExpenseToItems < ActiveRecord::Migration[6.1]
  def change
    add_column :saved_items, :expense_cost, :decimal
    add_column :line_items, :expense_cost, :decimal
  end
end
