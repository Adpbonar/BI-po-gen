class LineItemsController < ApplicationController
  before_action :set_line_item, only: %i[ edit update destroy ]
  before_action :authenticate_user!

  # GET /line_items/new
  def new
    @line_item = LineItem.new
  end


  # POST /line_items or /line_items.json
  def create
    @line_item = LineItem.new(line_item_params)
    respond_to do |format|
      if @line_item.save
        # format.html { redirect_to statement_path(@line_item.statement_id), notice: "Line item was successfully created." }
        format.json { render :show, status: :created, location: @line_item }
      else
        string = "<b>Errors:</b><br />"
        @line_item.errors.full_messages.each do |error|
          string = string + "<div>#{error}</div>".to_s
        end
        if @line_item.title.present?
          string = string + "Previusly inputed title: " + @line_item.title
        end
        if @line_item.description.present?
          string = string + "Previusly inputed description: " + @line_item.description
        end
        if @line_item.cost.present?
          string = string + "Previusly inputed cost: " + @line_item.cost.to_s
        end
      format.html { redirect_to statement_path(@line_item.statement.id), notice: string }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /line_items/1 or /line_items/1.json
  # def update
  #   respond_to do |format|
  #     if @line_item.update(line_item_params)
  #       format.html { redirect_to statement_path(@line_item.statement_id), notice: "Line item was successfully updated." }
  #       format.json { render :show, status: :ok, location: @line_item }
  #     else
  #       format.html { redirect_to statement_path(@line_item.statement_id), status: :unprocessable_entity }
  #       format.json { render json: @line_item.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # DELETE /line_items/1 or /line_items/1.json
  def destroy
    @line_item.destroy
    respond_to do |format|
      format.html { redirect_to line_items_url, notice: "Line item was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_line_item
      @line_item = LineItem.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def line_item_params
      params.require(:line_item).permit(:title, :description, :cost, :taxable, :type, :statement_id, :expense_exempt_from_tax)
    end
end
