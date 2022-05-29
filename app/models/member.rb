class Member < ApplicationRecord
  belongs_to :group

  def groupy
    RankingForm.find(self.client)
  end

  def name
    self.groupy.name
  end

  def email
    self.groupy.email
  end
end
