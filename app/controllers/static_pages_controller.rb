class StaticPagesController < ApplicationController
    before_action :authenticate_user!, only: :home
    before_action :user_check, only: :home

    def home
        @options = Company.first.company_options
    end

    private
    
    def user_check
        if user_signed_in? && (current_user.id == Company.first.company_options[:user])
            return true
        end
    end
end
