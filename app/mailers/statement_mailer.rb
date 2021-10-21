class StatementMailer < ApplicationMailer

    def pdf_attachment_method(statement)
        attachments["invoice_#{statement.invoice_number}.pdf"] =   WickedPdf.new.pdf_from_url("#{statement_url(statement)}.pdf")
        mail(to: 'info@bonarinstitute.com', subject: 'Your PDF is attached', statement: statement)
    end
end
