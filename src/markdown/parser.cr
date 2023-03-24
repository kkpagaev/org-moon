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

  def calendar(date : String) : Array(Event)
    parser = Markdown::Calendar::Parser.new(@text)
    list = parser.calendar_list
    list.map do |item|
      Event.new(
        title: item[:title],
        description: item[:description]?,
        date: date,
        start: item[:from],
        finish: item[:to]?,
      )
    end
  end
end
