class AddEncriptionToRankings < ActiveRecord::Migration[6.1]
  def change
    add_column :pos, :access_code_ciphertext, :text
    add_column :ranking_forms, :access_code_ciphertext, :text
    add_column :ranking_forms, :name_ciphertext, :text
    add_column :ranking_forms, :email_ciphertext, :text
    remove_column :pos, :access_code, :string
    remove_column :ranking_forms, :access_code, :string
    remove_column :ranking_forms, :name, :string
    remove_column :ranking_forms, :email, :string
  end
end
