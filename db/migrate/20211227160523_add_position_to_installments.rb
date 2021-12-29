class AddPositionToInstallments < ActiveRecord::Migration[6.1]
  def change
    add_column :installments, :position, :integer
  end
end
