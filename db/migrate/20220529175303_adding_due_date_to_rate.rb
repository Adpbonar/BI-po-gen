class AddingDueDateToRate < ActiveRecord::Migration[6.1]
  def change
    remove_column :rates, :session_count, :integer
    add_column :rates, :due_date, :datetime
  end
end
