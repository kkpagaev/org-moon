class NoteController < ApplicationController
  getter note = Note.new

  before_action do
    only [:show, :edit, :update, :destroy] { set_note }
  end

  def index
    book = Book.find params[:book_id]?
    tag_id = params[:tag_id]?
    if book
      qb = Note.where(book_id: book.id, user_id: current_user.try &.id)

      if tag_id
        qb = qb.where("id IN (SELECT note_id FROM tagging WHERE tag_id = $)", tag_id)
      end
      notes = qb.select
    else
      notes = Note.where(user_id: current_user.try &.id).select
    end
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
    tag_names = tags.gsub(/\s+/, "").split(",")
    Markdown::Builder::Page.new(name, tag_names, content).to_s
  end

  getter books = [] of Book

  def create
    note = Note.new notes_params.validate!
    note.user_id = current_user.try &.id
    note.body = build_markdown(params[:title], params[:tags], "")
    note.tag_names = params[:tags].split(",")
    books = Book.where(user_id: current_user.try &.id)

    if note.save
      tags = params[:tags].split(" ")
      redirect_to "/notes/#{note.id}/edit", flash: {"success" => "Note has been created."}
    else
      flash[:danger] = "Could not create Note!"
      render "new.slang"
    end
  end

  def update
    begin
      note.set_attributes update_note_params.validate!
      parser = MarkdownParser.new note.body.not_nil!
      note.title = parser.title
      note.tag_names = parser.tags
      note.save!

      redirect_to "/notes/#{note.id}/edit", flash: {"success" => "Note has been updated."}
    rescue e
      flash[:danger] = "Error: #{e.message}"
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
    @book = @note.book
  end
end
