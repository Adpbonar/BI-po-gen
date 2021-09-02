class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def as_percetage(number)
    self.to_f / n.to_f * 100
  end
end
