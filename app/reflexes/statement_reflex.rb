class StatementReflex < ApplicationReflex
  def toggle
    statement = Statement.find(element.dataset[:id])
    unless statement.associate
      if statement.valid?
        if statement.show_detailed 
            statement.update(show_detailed: false)
        else
            statement.update(show_detailed: true)
        end
      end
    end
  end
  
  def associates_generate
    statement = Statement.find(element.dataset[:id])
    po = statement.po
    # unless po.locked
      statement.generate_fixed_amount_associate_statements
      statement.generate_associate_statement
      po.set_status
     # end
  end

  def create_statement
    statement = Statement.find(element.dataset[:statement])
    party = Participant.find(element.dataset[:id])
    s = Statement.create(type: "AssociateStatement", po_id: statement.po.id, company_name: Company.first.company_name, company_address: Company.first.address, participant_name: party.name, participant_address: party.address, invoice_number: 'PO-' + statement.po.po_number.to_s + '-P-' + party.id.to_s, currency: party.currency, tax_rate: party.tax_rate, issued_to: party.id)
    StatementNote.create(statement_id: s.id, notes: Company.first.default_associate_note, terms: Company.first.default_associate_terms)
  end

  def send_statement
    statement = Statement.find(element.dataset[:id])
    if statement.po.status == 'All Statements Submitted'
      statement.send_out_statement
    end
  end
      
  def remove
    rate = Rate.find(element.dataset[:id])
    rate.destroy
  end
 
end