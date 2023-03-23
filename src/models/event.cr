class Event < Granite::Base
  connection pg
  table events

  belongs_to :note

  column id : Int64, primary: true
  column title : String
  column description : String
  column start_at : Time
  column end_at : Time?

  timestamps

  def initialize(title : String, description : String, date : String, start : String, finish : String? = nil)
    @title = title
    @description = description
    start_at = Time.parse( date + " " + start, "%d.%m.%Y %H:%M", Time::Location::UTC)
    end_at = Time.parse( date + " " + finish, "%d.%m.%Y %H:%M",Time::Location::UTC) unless finish.nil?
    @start_at = start_at
    @end_at = end_at
  end

  validate :start_at, "must be before end_at" do |e|
    if finsih = e.end_at
      e.start_at < finsih
    else
      true
    end
  end
end
