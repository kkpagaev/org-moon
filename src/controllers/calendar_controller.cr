class CalendarController < ApplicationController
  getter note = Note.new

  before_action do
    only [:edit, :update, :update] { set_note }
  end

  def index
# notes = Note.all
    render "index.slang"
  end

  def editor
    date = params[:date]

    render "edit.slang"
  end

  def save
    render "edit.slang"
  end

  private def set_note
    @note = Note.find! params[:id]
  end
end
