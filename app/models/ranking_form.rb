class RankingForm < ApplicationRecord
  has_many :rankings
  serialize :shuffled_people, Array
end
