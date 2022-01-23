class InvoicesController < ApplicationController
  before_action :set_invoice, only: %i[ show edit update destroy ]
  before_action :authenticate_user!

  # GET /invoices or /invoices.json
  def index
    @invoices = Invoice.all
  end

  # GET /invoices/1 or /invoices/1.json
  def show
    @item = Item.new
    @participant = Participant.find(@invoice.participant_id)
    @items = @invoice.items.all.order(:id)
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "Bonar Institute " + @invoice.type_of + @invoice.invoice_number.to_s,
        page_size: 'Letter',
        page_height: '11in',
        javascript_delay: 2000,
        page_width: '8.5in',
        layout: "invoice.html.erb",
        template: "invoices/show.html.erb",
        orientation: "Portrait",
        margin: { 
          top: '1cm',
          bottom: '1cm',
          left:   '1cm',
          right:  '1cm' 
        },
        lowquality: false,
        zoom: 1 
      end 
    end
  end

  # GET /invoices/new
  def new
    @invoice = Invoice.new
  end

  # GET /invoices/1/edit
  def edit
  end

  # POST /invoices or /invoices.json
  def create
    @invoice = Invoice.new(invoice_params)
    @invoice.user_id = current_user.id
    @invoice.invoice_number = @invoice.set_invoice_number
    @invoice.currency = @participant.currency

    respond_to do |format|
      if @invoice.save
        format.html { redirect_to @invoice, notice: "Invoice was successfully created." }
        format.json { render :show, status: :created, location: @invoice }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @invoice.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /invoices/1 or /invoices/1.json
  def update
    respond_to do |format|
      if @invoice.update(invoice_params)
        format.html { redirect_to @invoice, notice: "Invoice was successfully updated." }
        format.json { render :show, status: :ok, location: @invoice }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @invoice.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /invoices/1 or /invoices/1.json
  def destroy
    @invoice.destroy
    respond_to do |format|
      format.html { redirect_to invoices_url, notice: "Invoice was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_invoice
      @invoice = Invoice.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def invoice_params
      params.require(:invoice).permit(:po_id, :name, :participant_id, :description, :tax_rate, :terms, :notes, :type_of)
    end
end
