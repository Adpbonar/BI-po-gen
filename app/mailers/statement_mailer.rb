class StatementMailer < ApplicationMailer

    def pdf_attachment_method(statement)
        attachments["invoice_#{statement.invoice_number}.pdf"] =  File.read(statement_path(statement).to_s + '.pdf')
        mail(to: 'info@bonarinstitute.com', subject: 'Your PDF is attached', statement: statement)
    end
end
