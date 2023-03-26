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
    note = day.note_id ? day.note : day.default_note
    render "edit.slang"
  end

  def save
    if user_id = current_user.try &.id
      save_day_params.validate!
      day.page = params[:body]
      day.save!
    end
    redirect_to "/calendar/#{params[:date]}"
  end

  private def save_day_params
    params.validation do
      required :body
    end
  end
end
