class Markdown::List::Parser
  property list : Array(Hash(Symbol, String | Nil))
  property md : String
  class SyntaxError < Exception
  end

  def initialize(@md : String)
    @index = 0
    @list = [] of Hash(Symbol, String | Nil)
    @lines = @md.lines
  end

  def parse
    @index = 0
    while @index < @lines.size
      unless @lines[@index].starts_with?("- ")
        @index += 1
        next
      end
      title = @lines[@index][2..-1].strip
      description = parse_description
      @list << {
        :title => title,
        :description => description
      }
      @index += 1
    end
    @list
  end

  def parse_description : String | Nil
    return nil unless (@index + 1) < @lines.size && !@lines[@index + 1].starts_with?("- ")
    description = String.build do |builder|
      while (@index + 1) < @lines.size && !@lines[@index + 1].starts_with?("- ")
        @index += 1
        builder << " " + @lines[@index].strip
      end
    end
    description.strip
  end
end
