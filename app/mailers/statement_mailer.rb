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
        attachments["statement_#{statement.po_number}.pdf"] = WickedPdf.new.pdf_from_string(
                render_to_string(template: 'statements/show.html.erb', 
                    layout: 'statement.html.erb', 
                    pdf: 'filename', 
                    page_size: 'Letter',
                    page_height: '11in',
                    page_width: '8.5in',
                    layout: "statement.html.erb",
                    template: "statements/show.html.erb",
                    orientation: "Portrait",
                    margin: { 
                    top: '1cm',
                    bottom: '1cm',
                    left:   '1cm',
                    right:  '1cm' 
                    },
                    lowquality: false,
                    zoom: 1,
                    footer: { 
                    :center => "Bonar Institute Invoice # " + @statement.invoice_number.to_s + "  |  " +'Page: [page] of [topage]' 
                    }       
                )
            )
        mail(to: 'info@bonarinstitute.com', subject: 'Your PDF is attached')
    end
end
