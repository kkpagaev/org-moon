class NotesController < ApplicationController
  getter notes = Notes.new

  before_action do
    only [:show, :edit, :update, :destroy] { set_notes }
  end

  def index
    notes = Notes.all
    render "index.slang"
  end

  def show
    render "show.slang"
  end

  def new
    render "new.slang"
  end

  def edit
    render "edit.slang"
  end

  def create
    # return {foo: "bar"}.to_json if is_api_request?
    notes = Notes.new notes_params.validate!
    notes.user_id = current_user.not_nil!.id
    if notes.save
      redirect_to action: :index, flash: {"success" => "Notes has been created."}
    else
      flash[:danger] = "Could not create Notes!"
      render "new.slang"
    end
  end

  def update
    notes.set_attributes notes_params.validate!
    if notes.save
      redirect_to action: :index, flash: {"success" => "Notes has been updated."}
    else
      flash[:danger] = "Could not update Notes!"
      render "edit.slang"
    end
  end

  def destroy
    notes.destroy
    redirect_to action: :index, flash: {"success" => "Notes has been deleted."}
  end

  private def notes_params
    params.validation do
      required :book_id
      required :title
      required :body
    end
  end

  private def set_notes
    @notes = Notes.find! params[:id]
  end
end
