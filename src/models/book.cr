class Book < Granite::Base
  connection pg
  table books

  column icon : String

  belongs_to :user

  column id : Int64, primary: true
  column title : String?
  column is_system : Bool = false

  timestamps
end
