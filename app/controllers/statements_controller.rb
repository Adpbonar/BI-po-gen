class StatementsController < ApplicationController
  before_action :set_statement, only: %i[ show edit update destroy ]
  before_action :authenticate_user!

  # GET /statements or /statements.json
  def index
    @statements = Statement.all
  end

  # GET /statements/1 or /statements/1.json
  def show
    @line_item = LineItem.new
    @expenses = @statement.line_items.where(type: "ExpenseItem")
    @services = @statement.line_items.where(type: "ServiceItem")
    @installment_info = @statement.po.show_installments
    @discount = Discount.new
    @discounts = @statement.line_items
    @line_items = @statement.line_items.all.order([:type]).order([:id])
    @installments_amounts = @statement.po.installments.order(:position)
    @saved_items = SavedItem.all.order([:id]).reverse_order
    @pdf_chart_data = @statement.pdf_installment_chart
    @note = @statement.statement_note
    @company_info = Company.first
    @company = @company_info.company_options
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "Bonar Institute Invoice: " + @statement.invoice_number.to_s,
        page_size: 'Letter',
        page_height: '11in',
        page_width: '8.5in',
        layout: "statement.html.erb",
        template: "statements/show.html.erb",
        orientation: "Portrait",
        margin: { 
          top: '1cm',
          bottom: '1cm',
          left:   '1cm',
          right:  '1cm' 
        },
        lowquality: false,
        zoom: 1,
        footer: { content: render_to_string('pdffooter')}       
      end
    end 
  end

  # GET /statements/new
  def new
    @statement = Statement.new
  end

  # GET /statements/1/edit
  def edit
  end

  # POST /statements or /statements.json
  def create
    @statement = Statement.new(statement_params)

    respond_to do |format|
      if @statement.save
        format.html { redirect_to @statement, notice: "Statement was successfully created." }
        format.json { render :show, status: :created, location: @statement }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @statement.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /statements/1 or /statements/1.json
  def update
    respond_to do |format|
      if @statement.update(statement_params)
        format.html { redirect_to @statement, notice: "Statement was successfully updated." }
        format.json { render :show, status: :ok, location: @statement }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @statement.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /statements/1 or /statements/1.json
  def destroy
    @statement.destroy
    respond_to do |format|
      format.html { redirect_to statements_url, notice: "Statement was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_statement
      @statement = Statement.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def statement_params
      params.require(:statement).permit(:company_name, :terms, :show_detailed, :show_programs)
    end   
end
