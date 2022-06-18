class Rate < ApplicationRecord
  belongs_to :statement
  validates :title, presence: true

encrypts :person_id

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

  def set_title
    unless self.person.blank?
      unless self.title.include?("for")
        self.title = self.title.to_s + " for " + self.person_id.to_s.strip!
        self.save
      end
    end
  end

  TYPE = {
    'Pay after first period': 'First',
    'Pay after last period': 'Last',
    'Pay after each period': 'Ongoing'
  }

end
