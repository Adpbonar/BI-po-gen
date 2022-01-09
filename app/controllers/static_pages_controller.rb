class StaticPagesController < ApplicationController
    before_action :authenticate_user!, only: :default_options

    def default_options
        if user_check
            @options = Company.first.company_options
            @company = Company.first
            @installments = @options[:initial_installments].split(",")
        else
            render plain: "Unauthorized", status: :unauthorized
        end
    end

    private
    
    def user_check
        if user_signed_in? && (current_user.id == Company.first.company_options[:user])
            return true
        end
    end
end
