class ApplicationController < ActionController::Base

  def force_json
    request.format = :json
  end
  
end
