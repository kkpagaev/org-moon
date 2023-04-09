module Markdown::Page
  class Base
    def to_json(io)
    end
  end
end

class String
  def day_name
    Time.parse(self, "%d.%m.%Y", Time::Location::UTC).day_name
  end
end

class Day < Granite::Base
  connection pg
  table days

  # K to see macro result
  belongs_to :user
  belongs_to :note
  has_many events : Event

  column id : Int64, primary: true
  column date : String
  timestamps

  getter page : Markdown::Page::Day | Nil = nil

  def default
    book = Book.find_by! user_id: user_id, title: "Calendar", is_system: true
    tags = [date.day_name]

    builder = NoteBuilder::Calendar.new(date, tags, nil)

    note = Note.default book, builder
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
    u_id = self.user_id || raise "User must be set"
    if page = @page
      user_id = self.user_id
      note = Note.new
      note.title = page.title
      note.body = page.to_s
      note.user_id = u_id

      note.book = Book.find_calendar!(u_id)
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
        event = Event.new start_at: event_md.start_at,
          end_at: event_md.end_at,
          title: event_md.title,
          description: event_md.description

        event.user_id = user_id
        event.day_id = id
        event
      end

      Event.where(day_id: id, user_id: user_id).delete
      Event.import events
    end
  end

  validate :date, "Date must be in the format DD.MM.YYYY", ->(day : Day) do
    if day.date =~ /\d{2}\.\d{2}\.\d{4}/
      true
    else
      false
    end
  end
end
