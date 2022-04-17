module StatementsHelper
  def invoice_type(record)
    unless record.type == "GeneralStatement"
      if record.client
        return "Client"
      end
      if record.rs
        return "Share"
      end
      if record.founder
        return "Initiator"
      end 
      if ! record.founder || ! record.rs
        return "Associate"
      end
    else
      return "General"
    end
  end
end