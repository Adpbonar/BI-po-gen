class Invoice < ApplicationRecord
  has_many :items
  belongs_to :user
  belongs_to :participant
  validates :currency, presence: true
  validates :tax_rate, presence: true, numericality: true, :on => :update
  validates :type_of, presence: true, :on => :update

  HUMANIZED_ATTRIBUTES = {
    :type_of => "Type"
  }

  def self.human_attribute_name(attr, options = {}) # 'options' wasn't available in Rails 3, and prior versions.
    HUMANIZED_ATTRIBUTES[attr.to_sym] || super
  end

  def money(record)
    return (self.currency.to_s + number_to_currency(record).to_s.split("$").last).html_safe
  end

  def set_currency
    participant = Participant.find(self.participant_id)
    if self.currency == nil && (! participant.currency.blank?)
      self.currency = Participant.find(participant.id).currency
      self.save
    end
    if self.tax_rate == nil && (! participant.tax_rate.blank?)
      if participant.tax_rate == nil
        self.tax_rate = 0
        self.save
      else
        self.tax_rate = participant.tax_rate
        self.save
      end
    end
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
