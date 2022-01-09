class DefaultReflex < ApplicationReflex

  def check_string(string)
    string.scan(/\D/).empty?
  end

  def percentage_ceiling(string)
    total = 0
    array = string.split(" ").map(&:to_i) 
    array.each do |number| 
      n = number.to_i 
      if n == 0
        return false
      end
      total = total + n
    end
    if total == 100
      return true
    end
  end

  def change_default_installments
    company = Company.find(element.dataset[:id])
    installment_1 = element.dataset[:installment1].to_s
    installment_2 = element.dataset[:installment2].to_s
    installment_3 = element.dataset[:installment3].to_s
    unless installment_1 == "0" || installment_2 == "0" || installment_3 == "0"
      string = installment_1 + ", " + installment_2 + ", " + installment_3
      array  = string.split(",")
      if (! check_string(string)) && percentage_ceiling(string)
        if array.length == 3
          new_default_installments = string
          company.company_options[:initial_installments] = new_default_installments
          if company.save
                flash.alert = 'Default installments updated'
          else
            flash.alert = 'Default installments not updated'
          end
        end
      end
    else
      flash.alert = 'All installments must be greater than 0'
    end
  end

  def change_default_options
    company = Company.find(element.dataset[:id])
    ass_percent = element.dataset[:work]
    tax = element.dataset[:tax]
    share = element.dataset[:share]
    finder = element.dataset[:finder]
    unless share.blank? || share == "0" || share >= "60"
      company.company_options[:revenue_share] = share.to_f
    end
    unless finder.blank? || finder == "0" || finder >= "25"
      company.company_options[:business_finder] = finder.to_f
    end
    unless ass_percent.blank? || share == "0" || share >= "60"
      company.company_options[:associate_percentage] = ass_percent.to_f
    end
    unless tax.blank? || share == "0" || share >= "60"
      company.company_options[:tax_rate] = tax.to_f
    end
    if company.save
      flash.alert = 'Default settings updated'
    else
      flash.alert = 'Default settings not updated'
    end
  end
end