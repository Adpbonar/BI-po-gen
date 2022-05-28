class RatesController < ApplicationController
  before_action :set_statement_note, only: %i[ edit update ]
  before_action :authenticate_user!



  def update

  end

  private

  def rate_params
    params.require(:rate).permit(:notes, :terms)
  end

  def set_rate
    @rate = Rate.find(params[:id])
  end
end
