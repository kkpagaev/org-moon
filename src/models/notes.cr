class Notes < Granite::Base
  connection pg
  table notes

  belongs_to :user

  belongs_to :book

  column id : Int64, primary: true
  column title : String?
  column body : String?
  timestamps
end
