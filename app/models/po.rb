class Po < ApplicationRecord
    has_many :statements
    belongs_to :user
		has_many :statements
		has_many :po_users

		validates :po_number, uniqueness: true

    extend FriendlyId
    friendly_id :po_number, use: :slugged

		def set_up_po
			client = ClientStatement.new(po_id: self.id)
       (self.number_of_installments).times.each do 
        Installment.create(po_id: self.id) 
       end
			client.save
		end

		def issued_by
			if self.user.email.split('@').last == 'bonarinstitute.com'
				return "Issued by the Bonar Institute for Purposeful Leadership."
			else
				errors.add(:issued_by, message: "not valid")
        self.destroy
			end
		end

    # Set the po number
    def set_po_number
        last_po = Po.last
        unless last_po == nil
            return last_po.po_number + 1
        else
            return 1001
        end
    end

    def duration
        start_time = self.start_date
        end_time = self.end_date
        minutes = (end_time - start_time) / 1.minutes
        hours = (end_time - start_time) / 1.hours
        days = ((end_time - start_time) / 1.days).to_s.split(".").first.to_i
				months = ((end_time - start_time) / 1.months).round
        weeks = ((end_time - start_time) / 1.weeks).round
        float_hours = hours.to_s.split(".").last
        decimal_hour_convert = (("0." + float_hours.to_s).to_f * 1.minutes).round
        if days > 14
					return "#{weeks} weeks"
        elsif weeks > 8
					return "#{months} months"
        elsif minutes < 120
          if minutes > 60
            if decimal_hour_convert == 1
              return "1 hour & #{decimal_hour_convert} minute"
            else
              return "1 hour & #{decimal_hour_convert} minutes"
            end
          elsif minutes.to_s.split(".").last.include?("0")
            return "#{minutes.to_i} minutes"
          else
            return "#{minutes} minutes"
          end
        elsif hours >= 2 && hours < 24
          if float_hours == "0"
            return "#{hours.to_i} hours"
          elsif decimal_hour_convert == 1
            return "#{hours.to_i} hours & #{decimal_hour_convert} minute"
          else
            return "#{hours.to_i} hours & #{decimal_hour_convert} minutes"
          end
        else
          if days < 2
            return "#{days} day"
          else
            return "#{days} days"
          end
        end
      end
end