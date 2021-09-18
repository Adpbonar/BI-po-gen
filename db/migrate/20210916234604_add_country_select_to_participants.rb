class AddCountrySelectToParticipants < ActiveRecord::Migration[6.1]
  def change
    add_column :participants, :country_code, :string
  end
end
