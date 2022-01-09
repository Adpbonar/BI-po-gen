class AddDefaultNotes < ActiveRecord::Migration[6.1]
  def change
    add_column :companies, :default_client_note, :text
    add_column :companies, :default_associate_note, :text
    add_column :companies, :default_client_terms, :text
    add_column :companies, :default_associate_terms, :text
  end
end
