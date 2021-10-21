class StatementMailer < ApplicationMailer

    def pdf_attachment_method(statement)
        attachments["statement_#{statement.id}.pdf"] =   WickedPdf.new.pdf_from_string(render_to_string(template: 'statements/show.html.erb', layout: 'statement.html.erb', pdf: 'filename'))
        mail(to: 'info@bonarinstitute.com', subject: 'Your PDF is attached', statement: statement)
    end
end
