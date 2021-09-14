class Po < ApplicationRecord
    has_many :statements
    belongs_to :user
		has_many :installments
		has_many :po_users

		validates :po_number, uniqueness: true
    validates :title, presence: true
    validates_length_of :title, within: 1..100
    validates :start_date, presence: true
    validates :end_date, presence: true
    validates :service_type, presence: true
    validates :currency, presence: true
    validates :tax_amount, numericality: { in: 1..100 }
    validates :associate_percentage, numericality: { in: 1..100 }
    validates :founder_percentage, numericality: { in: 1..100 }
    validates_length_of :description, within: 0..600
    validate :in_future, :on => :create
    validate :time_duration
    # validate :start_date_is_valid_datetime
    # validate :end_date_is_valid_datetime

    extend FriendlyId
    friendly_id :po_number, use: :slugged


    # set up initial statement
		def set_up_po
			client = GeneralStatement.create(po_id: self.id)
      (self.number_of_installments).times.each do 
          installment = Installment.new(po_id: self.id) 
          installment.save
      end
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

    # estimate time to complete po
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

      def in_future
        unless start_date.blank?
          return if (start_date >= Date.today)
          errors.add :start_date, 'must be in the future.'
        end
      end
    
      def time_duration
        unless start_date.blank? || end_date.blank?
          return if end_date > start_date 
          errors.add :end_date, "cannot finish before it starts"
        end
      end

      def initilize_default_installments
        self.installments.each_with_index do |installment, index|
         if index == 0
            installment.percentage = 60
            installment.due_date = self.start_date
         elsif index == 2
            installment.due_date = self.end_date
            installment.percentage = 20
          else
            new_date = ((self.end_date.to_i - self.start_date.to_i) / 2)
            installment.due_date = self.start_date + new_date
            installment.percentage = 20
          end
        installment.save 
      end
    end

      def show_installments
        @installment_array = []
        self.installments.order(:id).map { |item| @installment_array << item.percentage.to_s + "%" }
        return @installment_array.join(" ")
      end

      def start_date_is_valid_datetime
        errors.add(:start_date, 'must be a valid datetime') if ((DateTime.parse(start_date) rescue ArgumentError) == ArgumentError)
      end

      def end_date_is_valid_datetime
        errors.add(:end_date, 'must be a valid datetime') if ((DateTime.parse(end_date) rescue ArgumentError) == ArgumentError)
      end

      TYPE = {
        'Training Programs': 'Modular Training Programs',
        'Coaching & Mentorship Programs': 'Modular Coaching and Mentorship Programs',
        'Integrated Programs': 'Integrated Programs',
        'Partnership Programs': 'Exclusive Partnership Porgrams'
      }

      CURRENCY = {
        'Canadian Dollar': 'CA $',
        'US Dollar': 'US $',
        'Euro': '&euro;',
        'British Pound': '&#163;',
    }
end