module Markdown
  class Parser::Page
    property md : String = ""

    class InvalidMarkdown < Exception
    end

    def initialize(@md : String)
    end

    def parse_title : String | Nil
      raise InvalidMarkdown.new("Markdown must start with \"# \"") unless @md.starts_with?("# ")

      /# \s*(\S+(?:\s+\S+)*)/.match(@md.lines[0]).try &.[1].to_s
    end

    def parse_tags(line_number = 1) : Array(String)
      @md.lines[line_number].scan(/#(\S+?(?=\s*#|\s*$))/).map { |tag| tag.try &.[1].to_s }
    end
  end
end
