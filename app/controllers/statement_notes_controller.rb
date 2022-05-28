class StatementNotesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_statement_note, only: %i[ edit update ]

  def edit
  end

  def update
    if @statement_note.update(statement_note_params)
      redirect_to statement_path(@statement_note.statement)
    end
  end

  private

  def statement_note_params
    params.require(:statement_note).permit(:notes, :terms)
  end

  def set_statement_note
    @statement_note = StatementNote.find(params[:id])
  end

end