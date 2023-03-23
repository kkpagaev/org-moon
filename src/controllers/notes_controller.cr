class NoteController < ApplicationController
  getter note = Note.new

  before_action do
    only [:show, :edit, :update, :destroy] { set_note }
  end

  def index
    notes = Note.all
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

  def whiteboard
    @note = Note.first! "WHERE user_id = ?", [current_user.try &.id]
    render "edit.slang"
  end

  def build_markdown(name, tags, content)
    "# #{name}  \n#{tags.split(",").map do |tag|
                      '#' + tag
                    end.join(" ")}  \n#{content}"
  end

  def create
    # return {foo: "bar"}.to_json if is_api_request?
    note = Note.new notes_params.validate!
    note.user_id = current_user.try &.id
    note.body = build_markdown(params[:title], params[:tags], params[:body])
    note.tag_names = params[:tags].split(",")

    if note.save
      tags = params[:tags].split(" ")
      redirect_to "/notes/#{note.id}/edit", flash: {"success" => "Note has been created."}
    else
      flash[:danger] = "Could not create Note!"
      render "new.slang"
    end
  end

  def update
    note.set_attributes update_note_params.validate!
    parser = MarkdownParser.new note.body.not_nil!
    note.title = parser.title
    note.tag_names = parser.tags
    if note.save
      redirect_to "/notes/#{note.id}/edit", flash: {"success" => "Note has been updated."}
    else
      flash[:danger] = "Could not update Note!"
      render "edit.slang"
    end
  end

  def destroy
    note.destroy
    redirect_to action: :index, flash: {"success" => "Note has been deleted."}
  end

  private def notes_params
    params.validation do
      required :book_id
      required :title
      required :body
      optional :tags
    end
  end

  private def update_note_params
    params.validation do
      required :body
    end
  end

  private def set_note
    @note = Note.find! params[:id]
  end
end
