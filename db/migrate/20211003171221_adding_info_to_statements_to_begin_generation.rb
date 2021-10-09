class AddingInfoToStatementsToBeginGeneration < ActiveRecord::Migration[6.1]
  def change
    add_column :statements, :total, :decimal, percision: 5
    add_column :pos, :issue_code, :string
    add_column :statements, :invoice_number, :string
    add_column :participants, :title_ciphertext, :text  
    add_column :participants, :city_ciphertext, :text
    add_column :participants, :state_ciphertext, :text
    add_column :participants, :zip_ciphertext, :text
    add_column :participants, :company_ciphertext, :text

    add_column :participants, :company_bidx, :string
    add_index :participants, :company_bidx
    add_column :participants, :city_bidx, :string
    add_index :participants, :city_bidx
    add_column :participants, :state_bidx, :string
    add_index :participants, :state_bidx
    add_column :participants, :zip_bidx, :string
    add_index :participants, :zip_bidx
    
    add_column :statements, :status_code, :string
  end
end
