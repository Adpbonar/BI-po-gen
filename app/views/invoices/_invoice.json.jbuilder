json.extract! invoice, :id, :po_id, :name,, :participant_id, :description, :tax_rate, :created_at, :updated_at
json.url invoice_url(invoice, format: :json)
