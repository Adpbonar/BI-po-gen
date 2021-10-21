class StatementMailer < ApplicationMailer

    def pdf_attachment_method(statement)
        attachments["invoice_#{statement.invoice_number}.pdf"] =   WickedPdf.new.pdf_from_string(template: 'statements/show.html.erb', layout: 'statement.html.erb', pdf: 'filename')
        mail(to: 'info@bonarinstitute.com', subject: 'Your PDF is attached', statement: statement)
    end
end
