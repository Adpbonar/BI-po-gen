class CreatePorfessionalRates < ActiveRecord::Migration[6.1]
  def change
    create_table :porfessional_rates do |t|
      t.string :title
      t.references :participant, null: false, foreign_key: true
      t.decimal :rate, :precision => 12, :scale => 9

      t.timestamps
    end
  end
end
