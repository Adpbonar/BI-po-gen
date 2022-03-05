class CreateAdjustments < ActiveRecord::Migration[6.1]
  def change
    create_table :adjustments do |t|
      t.references :statement, null: false, foreign_key: true
      t.string :name
      t.decimal :cost
      t.boolean :absolute, :default => false
      t.boolean :apply_to_all, :default => false
      t.boolean :taxed, :default => false

      t.timestamps
    end
  end
end
