class AddPersonIdToRates < ActiveRecord::Migration[6.1]
  def change
    add_column :rates, :person_id_ciphertext, :string
   
  end
end
