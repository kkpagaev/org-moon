struct CalendarEvent
  property start : String
  property title : String
  property description : String

  def initialize(@start : String, @title : String, @description : String = "")
  end
end

struct CalendarTask
  property start : String
  property finish : String
  property title : String
  property description : String

  def initialize(@start : String, @finish : String, @title : String, @description : String = "")
  end
end

class MarkdownParser
  property text : String = ""

  class InvalidMarkdown < Exception
  end

  def initialize(text : String)
    @text = text
  end

  def title : String
    raise InvalidMarkdown.new("Markdown must start with \"# \"") unless @text.starts_with?("# ")

    /# \s*(\S+(?:\s+\S+)*)/.match(@text.lines[0]).to_s
  end

  def tags : Array(String)
    @text.lines[1].scan(/#(\S+?(?=\s*#|\s*$))/).map { |tag| tag.to_s }
  end

  def calendar(start : Int64) : Array(CalendarTask | CalendarEvent)
    res = [] of CalendarTask | CalendarEvent
    matches = @text[start..-1].scan /(-\s(?<start>\d{1,2}:\d{2})[ ]*-?\s*(?<finish>\d{1,2}:\d{2})?\s+(?<title>\w*)?(  \n(?<desc>((\w+  \n)*\w+)))?)/
    matches.each do |match|
      desc = match["desc"]? || ""
      if match["finish"]?
        res << CalendarTask.new(match["start"], match["finish"], match["title"], desc)
      else
        res << CalendarEvent.new(match["start"], match["title"], desc)
      end
    end
    res
  end
end
