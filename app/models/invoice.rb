class Invoice < ApplicationRecord
  has_many :items

  def set_invoice_number
    last_invoice = Invoice.last
    unless last_invoice == nil
        last_number = (last_invoice.invoice_number.split("-").last.to_i + 1).to_s
        return "I-" + last_number
    else
        return "I-" + DateTime.current.strftime("%y").to_s + "10"
    end
  end

  TYPE = {
      'Charge': 'Charge',
      'Credit': 'Credit'
    }
end
