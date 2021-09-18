class AddExepseExemptFromTaxToLineItem < ActiveRecord::Migration[6.1]
  def change
    add_column :line_items, :expense_exempt_from_tax, :boolean, :default => false
    add_column :saved_items, :expense_exempt_from_tax, :boolean, :default => false
    add_column :saved_items, :taxable, :boolean, :default => true
  end
end
