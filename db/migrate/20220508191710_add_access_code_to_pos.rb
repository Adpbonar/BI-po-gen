class AddAccessCodeToPos < ActiveRecord::Migration[6.1]
  def change
    add_column :pos, :access_code, :string
    add_column :pos, :accepting_submissions, :boolean, :default => false 
    add_index :pos, :access_code
    add_column :pos, :fixed_payments, :boolean, :default => true 
    add_column :ranking_forms, :access_code, :string
    add_column :ranking_forms, :po_number, :integer
    add_column :ranking_forms, :email, :string
    add_column :participants, :profile, :text
    add_column :ranking_forms, :complete, :boolean, :default => false 
    add_column :ranking_forms, :shuffled_people, :text 
    add_column :rankings, :ranking_form_id, :integer
    add_column :rankings, :rank, :integer
    remove_column :rankings, :ranking, :integer
    remove_column :ranking_forms, :participants, :text
    remove_column :ranking_forms, :profile, :text
    remove_column :ranking_forms, :profile_name, :string
    remove_column :rankings, :ramking_form_id, :integer

  end
end
