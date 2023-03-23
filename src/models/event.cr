class Event < Granite::Base
  connection pg
  table events

  belongs_to :note

  column id : Int64, primary: true
  column title : String
  column description : String
  column from : Time
  column to : Time?
  timestamps
end
