class RankingFormsController < ApplicationController
  before_action :set_ranking_form, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except: %i[ new create show ]

  # GET /ranking_forms or /ranking_forms.json
  def index
    @ranking_forms = RankingForm.all.order(:id).reverse_order
  end

  # GET /ranking_forms/1 or /ranking_forms/1.json
  def show
    po = Po.where(po_number: @ranking_form.po_number).first
    if po.sorted
      redirect_to po_path(po)
    end
    if @ranking_form.shuffled_people.empty?
      @rusers = po.rusers.all
      @users = []
      @rusers.shuffle.each do  |associate| 
        party = Participant.find(associate.participant_id) 
        if party
          @users << party.id
        end
      end
      @users.length.times do
        @users = @users.shuffle!
      end
      @ranking_form.update(shuffled_people: @users)
    end
    @members = []
      @team = @ranking_form.shuffled_people.each do |party|
      part = Participant.find(party) 
      @members << part
    end
  end

  # GET /ranking_forms/new
  def new
    @ranking_form = RankingForm.new
  end

  # POST /ranking_forms or /ranking_forms.json
  def create
    @ranking_form = RankingForm.new(ranking_form_params)
    accepting_po = 1
    Po.all.each do |po|
      if po.access_code == @ranking_form.access_code
        accepting_po = po.id
        @ranking_form.po_number = po.po_number
      end
    end
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

  def update
    respond_to do |format|
      if @ranking_form.update(ranking_form_params)
        format.html { redirect_to po_path(Po.where(po_number: @ranking_form.po_number).first), notice: "Po was successfully updated." }
        format.json { render :show, status: :ok, location: @po }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @ranking_form.errors, status: :unprocessable_entity }
      end
    end
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_ranking_form
      @ranking_form = RankingForm.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def ranking_form_params
      params.require(:ranking_form).permit(:name, :access_code, :email, :ranking)
    end
end
