class Installment < ApplicationRecord

    require 'bigdecimal'

    belongs_to :po
    validates :due_date, presence: true
    validates :percentage, presence: true
    validate :reasonable_installment_due_date, :on => :update
    validate :installment_total
    validate :due_date_is_valid_datetime

    def percentage_amount(record1, record2)
        return (record1.to_i * ("0." + record2.to_s).to_f)
    end

    def installment_total
      unless po.status == "New"
        amount = 0.0
        installments = Installment.all.where(po_id: self.po_id)
        installments.each do |installment| 
          amount = amount.to_d + installment.percentage 
          if installment.percentage == 0.0 
              return errors.add :installment, 'cannot be 0'
          end
        end
      end
    end

    # Prevent due_date from being before the PO parent starts
    def reasonable_installment_due_date
      return if self.due_date >= self.po.start_date
      errors.add :due_date, 'must not be before the po start date'
    end

    def add_decimal(s)
      pfx = [ '0.00', '0.0', '0.' ]
      if(pfx[s.length])
        s = pfx[s.length] + s
      else
        s = s.dup
        s[-2, 0] = '.'
      end
      s
    end

    # Totaling statement line items and costing intallments
    def cost
      cost = 0.to_d
      items = self.po.statements.first.line_items.order(:id)
      items.each do |item|
          if item.discounts.any?
              unless item.calculate_discounts == "Free"
                  cost = cost + item.calculate_discounts.to_d
              end
          else
              cost = cost + item.cost
          end
      end
      percentage = self.percentage
      return (cost * ((add_decimal(percentage.to_s).to_d) / 100))
    end
    
    def lead_time
      return self.due_date + self.po.lead_time_in_days.days 
    end

    def total
        cost = 0.0
        items = self.po.statements.first.line_items.order(:id)
        items.each do |item|
            cost = cost + item.cost
        end
        return (cost * ("0." + self.percentage.to_s).to_f).to_d
    end

    # Verify datetime formatting is correct
    def due_date_is_valid_datetime
        errors.add(:due_date, 'must be a valid datetime') if ((DateTime.parse(due_date.to_s) rescue ArgumentError) == ArgumentError)
      end

      def date 
        return self.due_date.strftime("%b %e, %Y")
      end
      
      def check_string(string)
        string.scan(/\D/).empty?
      end
    
      def percentage_ceiling(string)
        total = 0.0
        array = string.split(" ").map(&:to_d) 
        array.each do |number| 
          n = number.to_i 
          if n == 0 || n == 0.0
            return false
          end
          total = total + number
        end
        if total == 100 || total == 100.0 
          return true
        end
      end

      def select_number_of_installments(installments)
        po = self.po
        multiple_installments = installments.to_i
        if (multiple_installments >= 3 && multiple_installments <= 60) && check_string(installments)
          po.installments.destroy_all
            date_collector = []
            num =  multiple_installments -2
            date = ((po.end_date.to_i - po.start_date.to_i) / num).round.abs
            perc = 100 / (multiple_installments.to_d)
            i = -1
            multiple_installments.times do 
              i = i + 1
              if po.installments.count == 0
                portion = Installment.new(po_id: po.id, percentage: perc, due_date: po.start_date, position: i.to_i + 1)
              else
                new_due_date = date_collector[-1] + date
                portion = Installment.new(po_id: po.id, percentage: perc, due_date: new_due_date, position: i.to_i + 1)
              end
              portion.save 
              date_collector << portion.due_date
            end
            po.number_of_installments = date_collector.length
            po.save
          return errors.add :installments,  'Installments adjusted. The default due dates has been provided.'
        end
      end

      def adjust_installments(installments)
        if installments == "100" && check_string(installments)
          po.installments.destroy_all
          portion = Installment.new(po_id: po.id, percentage: 100, due_date: po.start_date) 
          portion.save 
          po.number_of_installments = 1
          po.save
        elsif percentage_ceiling(installments) && ! check_string(installments)
          po.installments.destroy_all
          date_collector = []
          multiple_installments = installments.split(" ")
          num = (multiple_installments.length + 1) -2
          date = ((po.end_date.to_i - po.start_date.to_i) / num).round.abs
          multiple_installments.each_with_index do |installment, i| 
          ins = installment.to_d
            if i == 0
              portion = Installment.new(po_id: po.id, percentage: ins, due_date: po.start_date, position: i.to_i + 1)
            else
              new_due_date = date_collector[-1] + date
              portion = Installment.new(po_id: po.id, percentage: ins, due_date: new_due_date, position: i.to_i + 1)
            end
            portion.save 
            date_collector << portion.due_date
          end
          po.number_of_installments = date_collector.length
          po.save
        return errors.add :installments,  'Installments adjusted. The default due dates has been provided.'
      else
        return errors.add :installments, 'Installment could not be saved. Please refer to the pattern below the form.'
      end
    end
end
