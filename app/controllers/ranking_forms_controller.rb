class RankingFormsController < ApplicationController
  before_action :set_ranking_form, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except: %i[ new create show ]

  # GET /ranking_forms or /ranking_forms.json
  def index
    @ranking_forms = RankingForm.all
  end

  # GET /ranking_forms/1 or /ranking_forms/1.json
  def show
    @rusers = Po.where(po_number: @ranking_form.po_number).first.rusers.all
    @count = 0
    users = []
    @rusers.each do  |associate| 
      party = Participant.find(associate.participant_id) 
      if party
        users << party
      end
      @users = users.shuffle!
    end
  end

  # GET /ranking_forms/new
  def new
    @ranking_form = RankingForm.new
  end

  # GET /ranking_forms/1/edit
  def edit
  end

  # POST /ranking_forms or /ranking_forms.json
  def create
        @ranking_form = RankingForm.new(ranking_form_params)
        if po = Po.where(access_code: @ranking_form.access_code).first
          if po.accepting_submissions == true
            @ranking_form.po_number = po.po_number
        respond_to do |format|
          if @ranking_form.save
            format.html { redirect_to @ranking_form, notice: "Ranking form was successfully created." }
            format.json { render :show, status: :created, location: @ranking_form }
          else
            format.html { render :new, status: :unprocessable_entity }
            format.json { render json: @ranking_form.errors, status: :unprocessable_entity }
          end
        end
      end 
    end 
  end

  # PATCH/PUT /ranking_forms/1 or /ranking_forms/1.json
  def update
    respond_to do |format|
      if @ranking_form.update(ranking_form_params)
        format.html { redirect_to @ranking_form, notice: "Ranking form was successfully updated." }
        format.json { render :show, status: :ok, location: @ranking_form }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @ranking_form.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ranking_forms/1 or /ranking_forms/1.json
  def destroy
    @ranking_form.destroy
    respond_to do |format|
      format.html { redirect_to ranking_forms_url, notice: "Ranking form was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ranking_form
      @ranking_form = RankingForm.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def ranking_form_params
      params.require(:ranking_form).permit(:name, :access_code)
    end
end
