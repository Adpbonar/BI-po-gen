class MembersController < ApplicationController
  before_action :authenticate_user!
  
  def new
    @member = Member.new
  end


  # POST /members or /members.json
  def create
    @member = member.new(member_params)
    
    respond_to do |format|
      if @member.save
        format.html { redirect_to po_path(@member.group.po), notice: "member was successfully created." }
        format.json { render :show, status: :created, location: @member }
      else
        format.html { redirect_to po_path(@member.group.po), status: :unprocessable_entity }
        format.json { render json: @member.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def member_params
    params.require(:member).permit(:group_id, :client)
  end
end