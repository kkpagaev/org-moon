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
end
