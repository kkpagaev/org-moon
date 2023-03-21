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

  def build_markdown(name, tags, content)
    "# #{name}  \n#{tags.split(",").map do |tag| '#' + tag end .join(" ")}  \n#{content}"
  end

  def create
    # return {foo: "bar"}.to_json if is_api_request?
    note = Note.new notes_params.validate!
    note.user_id = current_user.try &.id
    note.body = build_markdown(params[:title], params[:tags], params[:body])

    if note.save
      tags = params[:tags].split(",")
      save_tags note.id, tags
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
    save_tags note.id, parser.tags
    if note.save
      redirect_to action: :index, flash: {"success" => "Note has been updated."}
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

  private def save_tags(note_id, tag_names : Array(String))
    tags = [] of Tag
    tag_names.each do |name|
      tag = Tag.find_or_create_by name: name, user_id: current_user.try &.id
      tags << tag
    end
    Tagging.where(note_id: note_id).delete
    tags.each do |tag|
      tagging = Tagging.new note_id: note_id, tag_id: tag.id
      tagging.save
    end
  end
end
