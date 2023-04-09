class BookController < ApplicationController
  before_action do
    only [:show, :edit, :update, :destroy] { set_book }
  end

  getter icons = ["gg-calendar", "gg-album"]

  def index
    books = Book.where(user_id: current_user.try &.id)
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
    unless book_params.valid?
      flash[:danger] = book_params.errors.first.message
      render "new.slang"
      return
    end

    book = Book.new book_params.validate!
    book.user_id = current_user.not_nil!.id
    if book.save
      redirect_to action: :index, flash: {"success" => "Book has been created."}
    else
      flash[:danger] = "Could not create Book!"
      render "new.slang"
    end
  end

  def update
    unless book_params.valid?
      redirect_to action: :edit, flash: {"danger" => book_params.errors.first.message}, params: { "id" => book.try &.id.to_s }
      return
    end

    book.set_attributes book_params.validate!
    if book.save
      redirect_to action: :index, flash: {"success" => "Book has been updated."}
    else
      flash[:danger] = "Could not update Book!"
      render "edit.slang"
    end
  end

  def destroy
    book.destroy
    redirect_to action: :index, flash: {"success" => "Book has been deleted."}
  end

  private def book_params
    params.validation do
      required :title
      required :icon
    end
  end

  private def set_book
    @book = Book.find! params[:id]
  end
end
