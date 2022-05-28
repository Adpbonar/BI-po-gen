class CreateRates < ActiveRecord::Migration[6.1]
  def change
    create_table :rates do |t|
      t.string :title
      t.references :participant
      t.decimal :rate, :precision => 12, :scale => 9
      t.integer :hours
      t.references :statement

      t.timestamps
    end
  end
end
