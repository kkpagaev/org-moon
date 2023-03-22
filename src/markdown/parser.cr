class MarkdownParser
  property text : String = ""

  class InvalidMarkdown < Exception
  end


  def initialize(text)
    @text = text
  end

  def title
    raise InvalidMarkdown.new("Markdown must start with \"# \"") unless @text.starts_with?("# ") 

    @text.lines.first[2..-1].strip
  end

  # TODO refactor
  def tags
    tagline = @text.lines[1].strip.split(" ").select { |word| word != "" }
    tagline.map { |tag| tag[1..-1] }
  end
end
