class BookController < ApplicationController
  getter book = Book.new

  before_action do
    only [:show, :edit, :update, :destroy] { set_book }
  end

  def index
    books = Book.all
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
    book = Book.new book_params.validate!
    if book.save
      redirect_to action: :index, flash: {"success" => "Book has been created."}
    else
      flash[:danger] = "Could not create Book!"
      render "new.slang"
    end
  end

  def update
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
      required :user_id
      required :title
    end
  end

  private def set_book
    @book = Book.find! params[:id]
  end
end
