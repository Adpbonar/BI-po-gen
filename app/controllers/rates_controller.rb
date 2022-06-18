class RatesController < ApplicationController
  before_action :set_rate, only: %i[ edit update ]
  before_action :authenticate_user!

  def new
    @rate = Rate.new
  end

  def edit
  end

  def create
    @rate = Rate.new(rate_params)

    respond_to do |format|
      if @rate.save
        @rate.set_title
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
        @rate.update_title
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
    params.require(:rate).permit(:title, :rate, :status, :due_date, :statement_id, :participant_id, :person_id)
  end

  def set_rate
    @rate = Rate.find(params[:id])
  end
end
