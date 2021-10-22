class StatementMailer < ApplicationMailer
    def sanitized_show_money(record1, record2)
      if record1.po.currency.html_safe.to_s.include?('$')
        return number_to_currency(record2)
      else
        return record1.po.currency.html_safe.to_s + number_to_currency(record2).split("$").last
      end
    end

    def pdf_attachment(statement)
        @statement = statement
        attachments["statement_#{statement.id}.pdf"] = WickedPdf.new.pdf_from_string(
            render_to_string(template: 'statements/show.html.erb', layout: 'statement.html.erb', pdf: 'filename')
            )
        mail(to: 'info@bonarinstitute.com', subject: 'Your PDF is attached')
    end
end
