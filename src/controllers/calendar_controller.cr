class CalendarController < ApplicationController
  def index
    notes = Note.all
    render "index.slang"
  end
end
