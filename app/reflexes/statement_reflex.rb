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
      statement.generate_associate_statement
      po.set_status
    # end
  end
      
 
end