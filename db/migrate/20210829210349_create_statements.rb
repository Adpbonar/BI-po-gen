class CreateStatements < ActiveRecord::Migration[6.1]
  def change
    create_table :statements do |t|
      t.integer :number
      t.integer :issued_by
      t.references :po, null: false, foreign_key: true
      t.string :type

      t.timestamps
    end
  end
end
