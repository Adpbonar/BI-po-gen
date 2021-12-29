class InstallmentsController < ApplicationController
  before_action :set_installment, only: %i[ show edit update destroy ]
  before_action :authenticate_user!

  # GET /installments/1/edit
  def edit
  end

  # PATCH/PUT /installments/1 or /installments/1.json
  def update
    respond_to do |format|
      if @installment.update(installment_params)
        format.html { redirect_to po_path(@installment.po), notice: "Installment was successfully updated." }
        format.json { render :show, status: :ok, location: @installment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @installment.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_installment
      @installment = Installment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def installment_params
      params.require(:installment).permit(:percentage, :due_date, position)
    end
end
