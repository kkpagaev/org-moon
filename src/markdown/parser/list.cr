class Markdown::Parser::List
  property list : Array(Markdown::List::Item) = [] of Markdown::List::Item
  property md : String
  class SyntaxError < Exception
  end

  def initialize(@md : String)
    @index = 0
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
      @list << Markdown::List::Item.new(title, description) if title
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
