class DiscountsController < ApplicationController
  before_action :set_discount, only: %i[ show edit update destroy ]
  before_action :authenticate_user!

  # GET /discounts or /discounts.json
  def index
    @discounts = Discount.all
  end

  # GET /discounts/new
  def new
    @discount = Discount.new
  end

  # POST /discounts or /discounts.json
  def create
    @discount = Discount.new(discount_params)
    unless @discount.line_item.calculate_discounts == "Free" || @discount.line_item.type == "ExpenseItem"
 
      respond_to do |format|
        if @discount.save
          # format.html { redirect_to @discount.line_litem.statement, notice: @discount.errors }
          format.json { render :show, status: :created, location: @discount }
          # format.turbo_stream { }
        else
          string = "<b>Discount Errors:</b><br />"
          @discount.errors.full_messages.each do |error|
            string = string + "<div>#{error}</div>".to_s
          end
          format.html { redirect_to statement_url(@discount.line_item.statement_id), notice: string } 
          format.json { render json: @discount.errors, status: :unprocessable_entity }
          # format.turbo_stream {  }
        end
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_discount
      @discount = Discount.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def discount_params
      params.require(:discount).permit(:amount, :amount_type, :line_item_id)
    end
end
