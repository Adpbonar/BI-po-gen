class CreateCompanies < ActiveRecord::Migration[6.1]
  def change
    create_table :companies do |t|
      t.string :company_name
      t.text :address
      t.timestamps
    end
  end
  add_column :statements, :company_name, :string
  add_column :statements, :company_address, :text
  add_column :statements, :participant_name_ciphertext, :string
  add_column :statements, :participant_address_ciphertext, :text
end
