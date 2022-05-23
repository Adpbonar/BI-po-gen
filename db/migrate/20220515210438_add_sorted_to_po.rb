class AddSortedToPo < ActiveRecord::Migration[6.1]
  def change
    add_column :pos, :sorted, :boolean, :default => false
  end
end
