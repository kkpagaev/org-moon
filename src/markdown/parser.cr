class MarkdownParser
  property title : String = ""
  property tags : Array(String) = [] of String
  property text : String = ""

  class InvalidMarkdown < Exception
  end


  def initialize(text)
    @text = text
    process
  end

  private def process
    process_title
    # todo regex to #[a-z0-9]+ 
    process_tags if @text.lines[1].starts_with?("#")
  end

  private def process_title
    raise InvalidMarkdown.new("Markdown must start with \"# \"") unless @text.starts_with?("# ") 

    @title = @text.lines.first[2..-1].strip
  end

  # TODO refactor
  private def process_tags
    tagline = @text.lines[1].strip.split(" ").select { |word| word != "" }
    @tags = tagline.map { |tag| tag[1..-1] }
  end
end
