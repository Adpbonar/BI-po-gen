module ApplicationHelper

    def read_date(record)
        record.strftime("%B %e, %Y")
      end
end
