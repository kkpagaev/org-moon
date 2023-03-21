class NoteController < ApplicationController
  getter notes = Note.new

  before_action do
    only [:show, :edit, :update, :destroy] { set_notes }
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
    <<-MARKDOWN 
      # #{name}
      #{tags.split(",").map do |tag|
      '#' + tag + ' '
      end .join(" ")} 

      #{content}
    MARKDOWN
  end

  def create
    # return {foo: "bar"}.to_json if is_api_request?
    note = Note.new notes_params.validate!
    note.user_id = current_user.try &.id
    note.body = build_markdown(params[:title], params[:tags], params[:body])

    if note.save
      save_tags(note.id)
      redirect_to action: :index, flash: {"success" => "Note has been created."}
    else
      flash[:danger] = "Could not create Note!"
      render "new.slang"
    end
  end

  def update
    notes.set_attributes notes_params.validate!
    if notes.save
      redirect_to action: :index, flash: {"success" => "Note has been updated."}
    else
      flash[:danger] = "Could not update Note!"
      render "edit.slang"
    end
  end

  def destroy
    notes.destroy
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

  private def set_notes
    @notes = Note.find! params[:id]
  end

  private def save_tags(note_id)
    names = params[:tags].split(",")
    tags = [] of Tag
    names.each do |name|
      tag = Tag.find_or_create_by(name: name)
      tags << tag
    end
    
    tags.each do |tag|
      tagging = Tagging.new note_id: note_id, tag_id: tag.id
      tagging.save
    end
  end
end
