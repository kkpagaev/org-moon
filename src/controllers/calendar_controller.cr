struct Time
  def first_day_of_month : Time
    Time.utc(year, month, 1, 0, 0, 0)
  end

  def calendar_offset
    at_beginning_of_month.day_of_week.to_i - 1
  end

  def next_month
    self + 1.month
  end

  def prev_month
    self - 1.month
  end

  def days_in_month
    at_end_of_month.day
  end

  def month_name
    ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"][month - 1]
  end
end

class CalendarController < ApplicationController
  getter month = Time.utc.at_beginning_of_month

  def index
    if param = params[:month]?
      month, year = param.split(".")
      @month = Time.utc(year.to_i, month.to_i, 1, 0, 0, 0).first_day_of_month
    end
    notes = Note.all
    render "index.slang"
  end
end
