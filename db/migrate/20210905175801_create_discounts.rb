class CreateDiscounts < ActiveRecord::Migration[6.1]
  def change
    create_table :discounts do |t|
      t.integer :percentage
      t.references :line_item, null: false, foreign_key: true

      t.timestamps
    end
  end
end
