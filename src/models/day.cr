class Day < Granite::Base
  connection pg
  table days

  belongs_to :note

  belongs_to :user

  column id : Int64, primary: true
  column date : String?
  timestamps
end
