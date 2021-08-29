class CreateInstallements < ActiveRecord::Migration[6.1]
  def change
    create_table :installements do |t|
      t.integer :percentage
      t.references :po, null: false, foreign_key: true

      t.timestamps
    end
  end
end
