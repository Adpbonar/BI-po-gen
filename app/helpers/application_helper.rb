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
    def show_percentage_amount(record1, record2)
      if record2.to_s.split(".").to_s[0] == "0" || record2.to_s[0] == "."
        return (record1.to_i * ("0." + record2.to_s.split(".").last.to_s).to_f)
      else
          if record2.to_s.split(".").first.size < 2
              return (record1.to_i * ("0.0" + record2.to_s.split(".").join).to_f)
          else
              return (record1.to_i * ("0." + record2.to_s).to_f)
          end
      end
    end

    def show_money(record1, record2)
      return record1.po.currency.html_safe.to_s + number_to_currency(record2).split("$").last
    end

    def sanitized_show_money(record1, record2)
      if record1.po.currency.html_safe.to_s.include?('$')
        return number_to_currency(record2)
      else
        return record1.po.currency.html_safe.to_s + number_to_currency(record2).split("$").last
      end
    end

end
