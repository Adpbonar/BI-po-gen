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
        @greeting_plain ="Hello #{@statement.participant_name}, You have a new #{@statement.kind?} attached to this message. If you have any questions or concerns, please don\'t hesitate to reach out. Kindest regards, The team at the Bonar Institute for Purposeful Leadership."
        @greeting = "<p>Hello #{@statement.participant_name},</p> <p>You have a new #{@statement.kind?} attached to this message.</p> <p>If you have any questions or concerns, please don\'t hesitate to reach out.</p> <p>Kindest regards,</p> <p><b>The team at the Bonar Institute for Purposeful Leadership.</b></p>"
        attachments["Bonar Institute for Purposeful Leadership - #{statement.kind?}_#{statement.invoice_number}.pdf"] = WickedPdf.new.pdf_from_string(
                render_to_string(template: 'statements/show.html.erb', 
                    layout: 'statement.html.erb', 
                    pdf: 'filename', 
                    page_size: 'Letter',
                    page_height: '11in',
                    page_width: '8.5in',
                    layout: "email_statement.html.erb",
                    template: "statements/show.html.erb",
                    orientation: "Portrait",
                    disposition: 'attachment',
                    disable_javascript: true,
                    margin: { 
                    top: '1cm',
                    bottom: '1cm',
                    left:   '1cm',
                    right:  '1cm' 
                    },
                    lowquality: true,
                    zoom: 1       
                )
        )
        mail(to: 'info@bonarinstitute.com', subject: "Your #{statement.kind?} is attached")
    end
end
