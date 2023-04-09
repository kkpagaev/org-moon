module NoteBuilder
  abstract class Base
    property title : String
    property tags : Array(String)
    property body : String?

    include Note::NoteBuilder

    def initialize(title : String, tags : Array(String), body : String?)
      @title = title
      @tags = tags
      @body = body
    end
  end


  class Calendar < Base
    def build : String
      list_builder = Markdown::Builder::EventList.new([
        Markdown::Event.new(title: "exercises", description: "", start_at: Time.utc(2015, 1, 1, 8, 30), end_at: Time.utc(2015, 1, 1, 9, 30)),
        Markdown::Event.new(title: "", description: "", start_at: Time.utc(2015, 1, 1, 10, 30), end_at: nil),
        Markdown::Event.new(title: "", description: "", start_at: Time.utc(2015, 1, 1, 12, 30), end_at: nil),
        Markdown::Event.new(title: "", description: "", start_at: Time.utc(2015, 1, 1, 15, 45), end_at: nil),
        Markdown::Event.new(title: "", description: "", start_at: Time.utc(2015, 1, 1, 18, 0), end_at: nil),
      ])

      builder = Markdown::Builder::Page.new(title, tags, list_builder)
      builder.build
    end
  end

  class Note
    def build(title : String, tags : Array, body : String?)
      builder = Markdown::Builder::Page.new(title, tags, body)
    end
  end
end
