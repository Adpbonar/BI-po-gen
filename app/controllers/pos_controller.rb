class PosController < ApplicationController
  before_action :set_po, only: %i[ show edit update destroy ]

  # GET /pos or /pos.json
  def index
    @pos = Po.all
  end

  # GET /pos/1 or /pos/1.json
  def show
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
    @po.po_number = @po.set_po_number
    respond_to do |format|
      if @po.save
        format.html { redirect_to @po, notice: "Po was successfully created." }
        format.json { render :show, status: :created, location: @po }
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
    @po.destroy
    respond_to do |format|
      format.html { redirect_to pos_url, notice: "Po was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_po
      @po = Po.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def po_params
      params.require(:po).permit(:references, :title, :text, :date_time)
    end
end
