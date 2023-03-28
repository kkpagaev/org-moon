class Event < Granite::Base
  connection pg
  table events

  belongs_to :note
  belongs_to :day
  belongs_to :user

  column id : Int64, primary: true
  column title : String
  column description : String?
  column start_at : Time
  column end_at : Time?

  timestamps

  validate :start_at, "must be before end_at" do |e|
    if finsih = e.end_at
      e.start_at < finsih
    else
      true
    end
  end

  def to_s
    if finish = end_at
      "#{start_at.to_s("%H:%M")} - #{finish.to_s("%H:%M")} #{title}"
    else
      "#{start_at.to_s("%H:%M")} #{title}"
    end
  end
end
