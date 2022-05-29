class RankingForm < ApplicationRecord

  encrypts :name, :email, :access_code
 
  has_many :rankings
  serialize :shuffled_people, Array
  validates :name, presence: true
  validates :access_code, presence: true
  validates :access_code, numericality: { greater_than: 1000 }
  validates :email, presence: true, format: { with: Devise.email_regexp }


  def selected_user
    if self.rankings.any?
      self.rankings.order(:rank).first.rank
    end
  end

  def selected
    if self.rankings.any?
      self.rankings.order(:rank).first.participant
    end
  end

  def winner
    Participant.find(self.ranking)
  end

  def po
    self.po_number
  end

  def adjust_counts(scores, forms, po)
    if ! po.sorted && ! po.accepting_submissions
      if forms.where(complete: true).all.count == forms.all.count
        usr_count = po.rusers.all.count
        unless usr_count == 0
          survey_count = (forms.where(complete: true).all.count).divmod(usr_count)
        else
          survey_count = (forms.where(complete: true).all.count).divmod(1)
        end
        s_count = survey_count.first
        sheets = forms.where(complete: true)
        i = 1
        sheets.all.each do |form|
          if i == usr_count
            i  = 2
          else
            i = i + 1
          end
          if scores
          party = scores.select { |i| i.include?(form.ranking) } 
            if party.length != s_count
              difference = (party.length - s_count).abs
              responses = sheets.where(ranking: form.ranking).last(difference).each do 
                  form.update(ranking: form.rankings.where(rank: i).first.participant.id)
                  p = party.pop
                  party << form.ranking
                  new_scores = scores.delete_if { |k| k == p }
                  scores = []
                  scores << new_scores
                  scores << party
              end
            end
          end
        end
      end
    end
    print scores.flatten
    po.update(sorted: true)
  end

end
