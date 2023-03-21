class Note < Granite::Base
  connection pg
  table notes

  belongs_to :user

  belongs_to :book

  has_many :tags, class_name: Tag, through: :tagging

  column id : Int64, primary: true
  column title : String?
  column body : String?
  timestamps
end
