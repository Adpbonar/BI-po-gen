class CreateHoursRequireds < ActiveRecord::Migration[6.1]
  def change
    create_table :hours_requireds do |t|
      t.integer :number_of_hours
      t.integer :item_id, nil: false
      t.string :reason

      t.timestamps
    end

    add_column :pos, :lead_time_in_days, :integer
  end
end
