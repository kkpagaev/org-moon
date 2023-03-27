class Day < Granite::Base
  connection pg
  table days

  # K to see macro result
  belongs_to :user
  belongs_to :note

  column id : Int64, primary: true
  column date : String
  timestamps

  property page : Markdown::Page::Day | Nil = nil

  def default_note : Note | ::Nil
    list_builder  = Markdown::Builder::EventList.new([
      Markdown::Event.new(title: "foo", description: "description", start_at: Time.utc(2015, 1, 1, 8, 30), end_at: Time.utc(2015, 1, 1, 9, 30)),
      Markdown::Event.new(title: "test", description: nil, start_at: Time.utc(2015, 1, 1, 10, 30), end_at: nil)
    ])
    builder = Markdown::Builder::Page.new(date, ["foo", "bar"], list_builder)

    # TODO: use a relation
    book = Book.find_by! user_id: user_id, title: "Calendar", is_system: true

    note = Note.new title: date, body: builder.to_s, user_id: user_id
    note.book = book

    note
  end

  private def parse_md(body : String)
    parser = MarkdownParser.new body
    parser.parse_day(date)
  end

  def page=(body : String)
    raise "User must be set" unless user_id

    @page = parse_md body
  end

  before_save :save_note

  private def save_note
    if page = @page
      note = Note.new
      note.title = page.title
      note.body = page.to_s
      note.user_id = user_id

      book = Book.find_by! user_id: user_id, title: "Calendar", is_system: true
      note.book = book
      if note.title != date
        raise "Title and date must match"
      end
      note.tag_names = page.tags
      note.save!
      @note_id = note.id
    end
  end

  after_save :save_events

  private def save_events
    if page = @page
      events = page.events.map do |event_md|
        event = Event.new start_at: event_md.start_at, end_at: event_md.end_at, title: event_md.title, description: event_md.description
        event.user_id = user_id
        event.day_id = id
        event
      end

      Event.where(day_id: id, user_id: user_id).delete
      Event.import events
    end
  end
end
