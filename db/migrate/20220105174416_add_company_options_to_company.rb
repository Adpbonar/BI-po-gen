class AddCompanyOptionsToCompany < ActiveRecord::Migration[6.1]
  def change
    add_column :companies, :company_options, :json, default: {}
  end
end
