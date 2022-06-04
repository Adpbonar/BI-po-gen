class Rate < ApplicationRecord
  belongs_to :statement

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

end
