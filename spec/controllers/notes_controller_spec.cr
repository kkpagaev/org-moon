require "./spec_helper"

def notes_hash
  {"user_id" => "1", "book_id" => "1", "title" => "Fake", "body" => "Fake"}
end

def notes_params
  params = [] of String
  params << "user_id=#{notes_hash["user_id"]}"
  params << "book_id=#{notes_hash["book_id"]}"
  params << "title=#{notes_hash["title"]}"
  params << "body=#{notes_hash["body"]}"
  params.join("&")
end

def create_notes
  model = Notes.new(notes_hash)
  model.save
  model
end

class NotesControllerTest < GarnetSpec::Controller::Test
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

describe NotesControllerTest do
  subject = NotesControllerTest.new

  it "renders notes index template" do
    Notes.clear
    response = subject.get "/notes"

    response.status_code.should eq(200)
    response.body.should contain("notes")
  end

  it "renders notes show template" do
    Notes.clear
    model = create_notes
    location = "/notes/#{model.id}"

    response = subject.get location

    response.status_code.should eq(200)
    response.body.should contain("Show Notes")
  end

  it "renders notes new template" do
    Notes.clear
    location = "/notes/new"

    response = subject.get location

    response.status_code.should eq(200)
    response.body.should contain("New Notes")
  end

  it "renders notes edit template" do
    Notes.clear
    model = create_notes
    location = "/notes/#{model.id}/edit"

    response = subject.get location

    response.status_code.should eq(200)
    response.body.should contain("Edit Notes")
  end

  it "creates a notes" do
    Notes.clear
    response = subject.post "/notes", body: notes_params

    response.headers["Location"].should eq "/notes"
    response.status_code.should eq(302)
    response.body.should eq "302"
  end

  it "updates a notes" do
    Notes.clear
    model = create_notes
    response = subject.patch "/notes/#{model.id}", body: notes_params

    response.headers["Location"].should eq "/notes"
    response.status_code.should eq(302)
    response.body.should eq "302"
  end

  it "deletes a notes" do
    Notes.clear
    model = create_notes
    response = subject.delete "/notes/#{model.id}"

    response.headers["Location"].should eq "/notes"
    response.status_code.should eq(302)
    response.body.should eq "302"
  end
end
