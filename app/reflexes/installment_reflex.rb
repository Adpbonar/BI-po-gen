class InstallmentReflex < ApplicationReflex

  def change
    installment = Installment.find(element.dataset[:id])
    installments = element.dataset[:installments]
    installment.adjust_installments(installments)
  end

  def select_installments
    installment = Installment.find(element.dataset[:id])
    installments = element.dataset[:installments]
    installment.select_number_of_installments(installments)
  end
end