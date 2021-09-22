# frozen_string_literal: true

class ItemReflex < ApplicationReflex

  def remove
    item = LineItem.find(element.dataset[:id])
    item.destroy
  end

  def add
    item = SavedItem.find(element.dataset[:id])
    statement = Statement.find(element.dataset[:statement])
    if item.type == 'SavedExpense'
      type_of = 'ExpenseItem'
    else
      type_of = 'ServiceItem'
    end
    line_item = LineItem.new(statement_id: statement.id, title: item.title, description: item.description, cost: item.cost, taxable: item.taxable, expense_exempt_from_tax: item.expense_exempt_from_tax, type: type_of)
    if line_item.valid?
      line_item.save
      flash.alert = 'Item Added'
    else
      flash.alert = 'Item cound not be saved'
    end
  end

  def save
    item = LineItem.find(element.dataset[:id])
    unless SavedItem.where(title: item.title, type: item.type).any?
      if item.type == 'ExpenseItem'
        type_of = 'SavedExpense'
      else
        type_of = 'SavedService'
      end
      line_item = SavedItem.new(title: item.title, description: item.description, cost: item.cost, taxable: item.taxable, expense_exempt_from_tax: item.expense_exempt_from_tax, type: type_of)
      if line_item.valid?
        line_item.save
        flash.alert = 'Item saved for future use'
      else
        flash alert = 'Item couldn\'t be saved'
      end
    end
  end
end