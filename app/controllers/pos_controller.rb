class PosController < ApplicationController
  before_action :set_po, only: %i[ show edit update destroy ]
  before_action :authenticate_user!

  # GET /pos or /pos.json
  def index
    @pos = Po.all
  end

  # GET /pos/1 or /pos/1.json
  def show
    po_issuer = @po.user
  end

  # GET /pos/new
  def new
    @po = Po.new
  end

  # GET /pos/1/edit
  def edit
  end

  # POST /pos or /pos.json
  def create
    @po = Po.new(po_params)
    @po.user = current_user
    @po.po_number = @po.set_po_number
    @po.associate_percentage = 50
    @po.founder_percentage = 10
    @po.profit_share = 7.5
    @po.number_of_installments = 3
    @po.status = "Generated"
    respond_to do |format|
      if @po.save
        format.html { redirect_to @po, notice: "Po was successfully created." }
        format.json { render :show, status: :created, location: @po }
        @po.set_up_po
        @po.initilize_default_installments
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @po.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pos/1 or /pos/1.json
  def update
    respond_to do |format|
      if @po.update(po_params)
        format.html { redirect_to @po, notice: "Po was successfully updated." }
        format.json { render :show, status: :ok, location: @po }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @po.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pos/1 or /pos/1.json
  def destroy
    @po.installments.destroy_all
    @po.statements.destroy_all
    @po.destroy
    respond_to do |format|
      format.html { redirect_to pos_url, notice: "Po was successfully destroyed." }
      format.json { head :no_content }
      format.turbo_stream { }
    end
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_po
      @po = Po.friendly.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def po_params
      params.require(:po).permit(:po_number, :title, :description, :start_date, :end_date, :tax_amount, :company_name, :number_of_installments, :service_type)
    end
end
