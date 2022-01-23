class AddInvoiceNumberToInvoice < ActiveRecord::Migration[6.1]
  def change
    add_column :invoices, :invoice_number, :string
    add_column :invoices, :type_of, :string
    add_column :invoices, :currency, :string
    add_column :statements, :currency, :string
    add_column :participants, :currency, :string
  end
end
