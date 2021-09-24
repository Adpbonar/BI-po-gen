class PosController < ApplicationController
  before_action :set_po, only: %i[ show edit update destroy ]
  before_action :authenticate_user!
  after_action :update_status, only: :show

  # GET /pos or /pos.json
  def index
    @pos = Po.all.order([:id]).reverse_order
  end

  # GET /pos/1 or /pos/1.json
  def show
    update_status
    po_issuer = @po.user
    @users = Participant.all
    @po_users = @po.po_users
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
    @po.revenue_share = 7.5
    @po.number_of_installments = 3
    @po.tax_amount = 13
    @po.currency = 'CA $' 
    @po.status = 'New' 
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
      params.require(:po).permit(:po_number, :title, :description, :start_date, :end_date, :tax_amount, :company_name, :number_of_installments, :service_type, :currency, :learning_coordinator, :show_participant)
    end

    def update_status
      if @po.status == 'New'
        @po.set_up_po
        @po.update(status: "Generated")
      else
        unless @po.status == 'Lapsed'
          if @po.statements.first.line_items.any?
            @po.update(status: 'Costed')
          end
          if @po.statements.first.line_items.any? && @po.po_users.any?
            @po.update(status: 'Populated')
          end
          if @po.statements.first.line_items.any? && @po.po_users.any?
            @po.update(status: 'Prepared')
          end
          if @po.statements.first.subtotal == 0
            @po.update(status: 'Generated')
          end
          if @po.end_date < Time.now
            @po.update(status: 'Lapsed')
          end
        end
      end
    end
end
