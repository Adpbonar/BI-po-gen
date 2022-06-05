class RatesController < ApplicationController
  before_action :set_statement_note, only: %i[ edit update ]
  before_action :authenticate_user!

  def new
    @po = Po.new
  end

  def create
    @rate = Rate.new(rate_params)

    respond_to do |format|
      if @rate.save
        format.html { redirect_to statement_path(@rate.statement), notice: "Statement was successfully created." }
        format.json { render :show, status: :created, location: @rate }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @rate.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @rate.update(rate_params)
        format.html { redirect_to statement_path(@rate.statement), notice: "rate was successfully updated." }
        format.json { render :show, status: :ok, location: @rate }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @rate.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def rate_params
    params.require(:rate).permit(:title, :rate, :status)
  end

  def set_rate
    @rate = Rate.find(params[:id])
  end
end
