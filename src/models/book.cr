class Book < Granite::Base
  connection pg
  table books

  belongs_to :user

  column id : Int64, primary: true
  column title : String?
  timestamps
end
