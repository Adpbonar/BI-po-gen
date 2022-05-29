class Member < ApplicationRecord
  belongs_to :group

  def name
    RankingForm.find(self.client).name
  end

  def email
    RankingForm.find(self.client).email
  end
end
