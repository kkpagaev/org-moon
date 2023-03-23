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

  def tags(line_number = 1) : Array(String)
    @text.lines[line_number].scan(/#(\S+?(?=\s*#|\s*$))/).map { |tag| tag.try &.[1].to_s }
  end
end
