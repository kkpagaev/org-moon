class DayController < ApplicationController
  property day : Day

  # TODO make date validation
  def initialize(args)
    super(args)
    if date = params[:date]
      @day = Day.find_or_initialize_by(date: date, user_id: current_user!.id)
    else
      raise "No date provided"
    end
    @book = @day.note.book
  end

  def editor
    note = day.note_id ? day.note : day.default_note
    render "edit.slang"
  end

  def save
    save_day_params.validate!
    day.page = params[:body]
    day.save!
    redirect_to "/day/#{params[:date]}"
  end

  private def save_day_params
    params.validation do
      required :body
    end
  end
end
