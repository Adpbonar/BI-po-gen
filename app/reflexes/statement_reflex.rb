class StatementReflex < ApplicationReflex
  def toggle
    statement = Statement.find(element.dataset[:id])
    if statement.valid?
      if statement.show_detailed 
          statement.update(show_detailed: false)
      else
          statement.update(show_detailed: true)
      end
    end
  end
    
      
  def show
    statement = Statement.find(element.dataset[:id])
    if statement.valid?
        statement.update(show_programs: true)
    end
   end

  def hide
    statement = Statement.find(element.dataset[:id])
    if statement.valid?
        statement.update(show_programs: false)
        morph :page
    end
  end
end