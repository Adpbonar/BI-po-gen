class Rate < ApplicationRecord
  belongs_to :statement

  validates :due_date, presence: true
  validates :rate, presence: true

  def date
    self.due_date
  end

  def payment_date
    (date + self.statement.po.lead_time_in_days.days)
  end

  def person
    self.title.split("for").last
  end

  def item
    self.title.split("for").first
  end

  TYPE = {
    'Pay after first period': 'First',
    'Pay after last period': 'Last',
    'Pay after each period': 'Ongoing'
  }

end
