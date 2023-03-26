class DayController < ApplicationController
  property day : Day

  def initialize(args)
    super(args)
    if date = params[:date]
      if day = Day.find_by(date: date, user_id: current_user.try &.id)
        @day = day
      else
        @day = Day.new user_id: current_user.try &.id, date: params[:date]
      end
    else
      raise "No date provided"
    end
  end

  def editor
    note = day.note
    render "edit.slang"
  end

  def save
    if user_id = current_user.try &.id
      note = @day.note
      note.set_attributes save_day_params.validate!
      parser = MarkdownParser.new note.body.not_nil!
      day_md = parser.parse_day(day.date)
      note.title = day_md.title
      if note.title != params[:date]
        raise "Title and date must match"
      end
      note.tag_names = day_md.tags
      note.save!
      day.note = note
      day.save!
      events = day_md.events.map do |event_md|
        event = Event.new start_at: event_md.start_at, end_at: event_md.end_at, title: event_md.title, description: event_md.description
        event.user_id = user_id
        event.day_id = @day.id
        event
      end
      Event.where(day_id: @day.id, user_id: user_id).delete
      Event.import events
    end
    redirect_to "/day/#{params[:date]}"
  end

  private def save_day_params
    params.validation do
      required :body
    end
  end
end
