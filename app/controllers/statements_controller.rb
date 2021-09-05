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
      params.fetch(:statement, {})
    end
end
