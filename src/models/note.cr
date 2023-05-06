class Note < Granite::Base
  module NoteBuilder
    abstract def title : String
    abstract def tags : Array(String)
    abstract def content : String?

    abstract def body : String
  end

  module NoteParser
    abstract def title : String
    abstract def tags : Array(String)
    abstract def content : String?
  end

  def self.default(book : Book, builder : NoteBuilder)
    note = Note.new title: builder.title, body: builder.body
    note.book = book

    note
  end

  connection pg
  table notes

  belongs_to :user

  belongs_to :book

  has_many :tags, class_name: Tag, through: :tagging

  column id : Int64, primary: true
  column title : String?
  column body : String
  column is_hidden : Bool = false
  timestamps

  property tag_names : Array(String) | Nil = nil

  after_save :save_tags
  after_update :save_tags
  before_update :parse_body

  private def parse_body
    return if body.nil?
    parser = MarkdownParser.new body

    self.title = parser.title
    self.tag_names = parser.tags
  end

  private def save_tags
    return if tag_names.nil?
    tags = [] of Tag
    tag_names.try &.each do |name|
      tag = Tag.find_or_create_by name: name, user_id: user.id
      tags << tag
    end
    Tagging.where(note_id: id).delete
    tags.each do |tag|
      tagging = Tagging.new note_id: id, tag_id: tag.id
      tagging.save
    end
  end

  def self.new(book : Book, user : User, parser : NoteBuilder)
    note = Note.new title: parser.title, body: parser.body
    note.book_id = book.id
    note.user_id = user.id
    note.tag_names = parser.tags

    note
  end

  def body=(builder : NoteBuilder)
    title = builder.title
    tag_names = builder.tags
    body = builder.body
  end
end
