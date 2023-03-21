class Tagging < Granite::Base
  connection pg
  table tagging

  belongs_to :note, class_name: "Note"
  belongs_to :tag, class_name: "Tag"

  column id : Int64, primary: true
  column note_id : Int64
  column tag_id : Int64
  timestamps
end

class Tag < Granite::Base
  connection pg
  table tags

  has_many :notes, class_name: Note, through: :tagging

  column id : Int64, primary: true
  column name : String?

  belongs_to :user

  timestamps
end
