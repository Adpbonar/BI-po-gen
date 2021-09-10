module ApplicationHelper
   
    # Show readable date
    def read_date(record)
      record.strftime("%B %e, %Y")
    end

      # Show currency
    def show_currency(record)
      record.currency.html_safe
    end

    # convert precentages
    def as_percetage(number)
      self.to_f / n.to_f * 100
    end
end
