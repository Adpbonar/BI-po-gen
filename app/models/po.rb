class Po < ApplicationRecord
    has_many :statements
    belongs_to :user
		has_many :installments
		has_many :po_users
    has_many :groups
    
    encrypts :learning_coordinator, type: :integer
    encrypts :found, type: :integer
    encrypts :issued_to, :company_name, :approved_by

		validates :po_number, presence: true, uniqueness: true
    validates :title, presence: true
    validates_length_of :title, in: 1..100
    validates :start_date, presence: true
    validates :end_date, presence: true
    validates :service_type, presence: true
    validates :currency, presence: true, :on => :update
    validates :tax_amount, numericality: { in: 1..100 }, :on => :update
    validates :associate_percentage, presence: true, numericality: { in: 1..50 }
    validates :founder_percentage, presence: true, numericality: { in: 1..25 }
    validates_length_of :description, in: 0..600
    validate :in_future, :on => :create
    validate :time_duration

    extend FriendlyId
    friendly_id :po_number, use: :slugged
			
    # Verify organization of email
		def issued_by
			if self.user.email.split('@').last == 'bonarinstitute.com'
				return "<b>Issued by:</b> the Bonar Institute for Purposeful Leadership Inc."
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

    def options
      company = Company.first
      if ! company.company_options.to_s.blank? 
        return company.company_options
      else
        errors.add :company_options, 'not set.'
      end
    end

    # estimate time to complete po
    def duration
        start_time = self.start_date
        end_time = self.end_date
        # defualt time units
        minutes = (end_time - start_time) / 1.minutes
        hours = (end_time - start_time) / 1.hours
        days = ((end_time - start_time) / 1.days).to_s.split(".").first.to_i
        weeks = ((end_time - start_time) / 1.weeks).round
        months = ((end_time - start_time) / 1.months).round
        years = ((end_time - start_time) / 1.years).round
        # smaller units of time
        float_hours = hours.to_s.split(".").last
        decimal_hour_convert = (("0." + float_hours.to_s).to_f * 1.minutes).round
        if months > 24
          return "#{years} years"
        elsif weeks > 8
          return "#{months} months"
        elsif days > 14
            return "#{weeks} weeks"
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

      # Add error if po does not start in future
      def in_future
        unless start_date.blank?
          return if (start_date >= Date.today)
          errors.add :start_date, 'must be in the future.'
        end
      end
    
      # Add error if the end_date is before the start
      def time_duration
        unless start_date.blank? || end_date.blank?
          return if end_date > start_date 
          errors.add :end_date, "cannot finish before it starts"
        end
      end

      # Add default settings to the PO installments created earlier
      def initilize_default_installments
        defaults = self.options[:initial_installments].split(",")
        installments = self.installments
        amount = 0.0
        position = 0
        installments.map { |installment| amount = amount + installment.percentage.to_f }
        if amount >= 99.0 && amount < 100.01
          installments.each_with_index do |installment, index|
            position = position + 1 
            if index == 0
                installment.percentage = defaults[0].to_i
                installment.due_date = self.start_date
                installment.position = position
            elsif index == 2
                installment.due_date = self.end_date
                installment.percentage = defaults[1].to_i
                installment.position = position
            else
              new_date = ((self.end_date.to_i - self.start_date.to_i) / 2)
              installment.due_date = self.start_date + new_date
              installment.percentage = defaults[2].to_i
              installment.position = position
            end
          installment.save 
        end
      end
      return (amount.to_i).to_s + "%"
    end

    # set up initial statement and create blank installments for the PO
		def set_up_po
			GeneralStatement.create(po_id: self.id, company_name: Company.last.company_name, company_address: Company.last.address)
      (self.number_of_installments).times.each do 
          installment = Installment.create(po_id: self.id, due_date: Time.now, percentage: 33.33) 
      end
      if self.installments.count == self.options[:initial_installments].split(",").length
        self.initilize_default_installments
      end
    end

    # Show installment percentages on one line
    def show_installments
      @installment_array = []
      self.installments.order(:id).map { |item| @installment_array << item.percentage.to_s + "%" }
      return @installment_array.join(" ")
    end

    # Type of program being offered form dropdown
    TYPE = {
      'Training Programs': 'Modular Training Programs',
      'Coaching & Mentorship Programs': 'Modular Coaching and Mentorship Programs',
      'Integrated Programs': 'Integrated Programs',
      'Partnership Programs': 'Exclusive Partnership Porgrams'
    }

    # Type of currency being accepted form dropdown
    CURRENCY = {
      'Canadian Dollar': 'CA $',
      'US Dollar': 'US $',
      'Euro': '&euro;',
      'British Pound': '&#163;',
    }

    def show_coordinator
      unless self.learning_coordinator.blank?
        participant = Participant.find(self.learning_coordinator)
        return (participant.name.to_s + ", " + '<a href="mailto:' + participant.emailaddress.to_s + '">' + participant.emailaddress.to_s + '</a>').html_safe
      else
        return 'Bonar Institute for Purposeful Leadership, <a href="mailto:info@bonarinstitute.com">info@bonarinstitute.com</a>'.html_safe
      end
    end

    def locked
      statement = self.statements.first
      if statement.type == 'GeneralStatement'
        if statement.status_code == 'A' || statement.status_code == 'L'
          return true
        end
      end
    end

    def show_found
      unless self.found.blank?
        participant = Participant.find(self.found)
        return participant.name.to_s + " " + participant.emailaddress.to_s
      end
    end

    def associates
      Participant.where(type: 'Associate').each do |user|
        if user.po_users.where(po_id: self.id).any? 
          return true
        end
      end
    end

    def clients
      Participant.where(type: 'Client').each do |user|
        if user.po_users.where(po_id: self.id).any? 
          return true
        end
      end
    end

    def set_status
      if self.status == 'New'
        self.set_up_po
        self.update(status: "Generated")
      else
        unless self.status == 'Lapsed'
          if self.statements.first.line_items.any?
            self.update(status: 'Costed')
          end
          if self.statements.first.line_items.any? && self.po_users.any?
            self.update(status: 'Populated')
          end
          if self.statements.first.line_items.any? && (clients && associates)
            self.update(status: 'Prepared')
          end
          if self.statements.first.subtotal == 0
            self.update(status: 'Generated')
          end
          if self.end_date < Time.now && (! self.status == "Associate Submitted" || ! self.status == "Submitted")
            self.update(status: 'Lapsed')
          end
        end
      end
      if self.statements.where(type: 'AssociateStatement').count >= 1
        self.update(status: 'Associate Submitted')
      end
    end
end