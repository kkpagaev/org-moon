class CalendarController < ApplicationController
  getter note = Note.new
  property day : Day | Nil

  before_action do
    only [:editor, :save] { set_day }
  end

  def index
    notes = Note.all
    render "index.slang"
  end

  def editor
    if date = params[:date]
      render "edit.slang"
    end
  end

  def save
    if d = @day
    else
      note = Note.new
      note.set_attributes save_day_params.validate!
      parser = MarkdownParser.new note.body.not_nil!
      note.title = parser.title
      if note.title != params[:date]
        raise "Title and date must match"
      end
      events = parser.calendar (params[:date])
      note.tag_names = parser.tags
      note.save!
      day = Day.create(date: params[:date], user_id: current_user.try &.id, note_id: note.id)
      day.save!
      Event.import events
    end
    redirect_to "/"
  end

  private def save_day_params
    params.validation do
      required :body
    end
  end

  private def set_day
    @day = Day.find_by(date: params[:date])
  end
end
