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

  property tag_names : Array(String) | Nil = nil

  after_save :save_tags

  private def save_tags
    return if tag_names.nil?
    tags = [] of Tag
    tag_names.try &.each do |name|
      tag = Tag.find_or_create_by name: name, user_id:  user.id
      tags << tag
    end
    Tagging.where(note_id: id).delete
    tags.each do |tag|
      tagging = Tagging.new note_id: id, tag_id: tag.id
      tagging.save
    end
  end
end
