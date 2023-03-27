require "./parser/*"
require "./types"
require "./builder"

class MarkdownParser
  property text : String = ""

  class InvalidMarkdown < Exception
  end

  def initialize(text : String)
    @text = text
  end

  def title : String | Nil
    raise InvalidMarkdown.new("Markdown must start with \"# \"") unless @text.starts_with?("# ")

    /# \s*(\S+(?:\s+\S+)*)/.match(@text.lines[0]).try &.[1].to_s
  end

  def tags(line_number = 1) : Array(String)
    @text.lines[line_number].scan(/#(\S+?(?=\s*#|\s*$))/).map { |tag| tag.try &.[1].to_s }
  end

  def parse_day(date : String) : Markdown::Page::Day
    ptitle = title
    ptags = tags
    parser = Markdown::Parser::Calendar.new(@text)
    list = parser.calendar_list date
    day = Markdown::Page::Day.new(ptitle, ptags, list)
    day
  end
end
