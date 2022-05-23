class Ranking < ApplicationRecord
  belongs_to :ranking_form
  belongs_to :participant
end
