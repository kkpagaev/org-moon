class DayController < ApplicationController
  property day : Day

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
    note = day.note_id ? day.note : day.default
    render "edit.slang"
  end

  def save
    begin
      save_day_params.validate!
      day.page = params[:body]
      day.save!

      flash[:success] = "Saved"
      redirect_to "/day/#{params[:date]}"
    rescue e
      flash[:danger] = "Error: #{e.message}"
      editor
    end
  end

  private def save_day_params
    params.validation do
      required :body
    end
  end
end
