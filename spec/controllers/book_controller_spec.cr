require "./spec_helper"

def book_hash
  {"user_id" => "1", "title" => "Fake"}
end

def book_params
  params = [] of String
  params << "user_id=#{book_hash["user_id"]}"
  params << "title=#{book_hash["title"]}"
  params.join("&")
end

def create_book
  model = Book.new(book_hash)
  model.save
  model
end

class BookControllerTest < GarnetSpec::Controller::Test
  getter handler : Amber::Pipe::Pipeline

  def initialize
    @handler = Amber::Pipe::Pipeline.new
    @handler.build :web do
      plug Amber::Pipe::Error.new
      plug Amber::Pipe::Session.new
      plug Amber::Pipe::Flash.new
    end
    @handler.prepare_pipelines
  end
end

describe BookControllerTest do
  subject = BookControllerTest.new

  it "renders book index template" do
    Book.clear
    response = subject.get "/books"

    response.status_code.should eq(200)
    response.body.should contain("books")
  end

  it "renders book show template" do
    Book.clear
    model = create_book
    location = "/books/#{model.id}"

    response = subject.get location

    response.status_code.should eq(200)
    response.body.should contain("Show Book")
  end

  it "renders book new template" do
    Book.clear
    location = "/books/new"

    response = subject.get location

    response.status_code.should eq(200)
    response.body.should contain("New Book")
  end

  it "renders book edit template" do
    Book.clear
    model = create_book
    location = "/books/#{model.id}/edit"

    response = subject.get location

    response.status_code.should eq(200)
    response.body.should contain("Edit Book")
  end

  it "creates a book" do
    Book.clear
    response = subject.post "/books", body: book_params

    response.headers["Location"].should eq "/books"
    response.status_code.should eq(302)
    response.body.should eq "302"
  end

  it "updates a book" do
    Book.clear
    model = create_book
    response = subject.patch "/books/#{model.id}", body: book_params

    response.headers["Location"].should eq "/books"
    response.status_code.should eq(302)
    response.body.should eq "302"
  end

  it "deletes a book" do
    Book.clear
    model = create_book
    response = subject.delete "/books/#{model.id}"

    response.headers["Location"].should eq "/books"
    response.status_code.should eq(302)
    response.body.should eq "302"
  end
end
