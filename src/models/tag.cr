require "digest"

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
  column name : String

  belongs_to :user

  timestamps

  def color
    hash = Digest::SHA256.hexdigest(name)
    hex = '#' + hash[0..5]
    return hex
  end

  def text_color
    hex_color = color.gsub("#","")
    red = hex_color[0..1].to_i(16)
    green = hex_color[2..3].to_i(16)
    blue = hex_color[4..5].to_i(16)

    luminance = 0.2126 * red + 0.7152 * green + 0.0722 * blue

    return (luminance > 128) ? "#16161d" : "#dcd7ba"
  end
end
