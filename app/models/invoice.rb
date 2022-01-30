class Invoice < ApplicationRecord
  has_many :items
  belongs_to :user
  belongs_to :participant
  validates :currency, presence: true
  validates :type_of, presence: true

  HUMANIZED_ATTRIBUTES = {
    :type_of => "Type"
  }

  def self.human_attribute_name(attr, options = {}) # 'options' wasn't available in Rails 3, and prior versions.
    HUMANIZED_ATTRIBUTES[attr.to_sym] || super
  end


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
