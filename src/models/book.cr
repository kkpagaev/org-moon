class Book < Granite::Base
  connection pg
  table books

  column icon : String = "gg-album"

  belongs_to :user

  column id : Int64, primary: true
  column title : String?
  column is_system : Bool = false
  column is_hidden : Bool = false

  timestamps

  def self.find_calendar(user_id : Int64)
    Book.find_by user_id: user_id, title: "Calendar", is_system: true
  end

  def self.find_calendar!(user_id : Int64)
    Book.find_calendar(user_id) || raise "Calendar not found"
  end
end
