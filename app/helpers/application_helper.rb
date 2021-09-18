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

    def show_money(record1, record2)
      return record1.po.currency.html_safe.to_s + number_to_currency(record2).split("$").last
    end

end
