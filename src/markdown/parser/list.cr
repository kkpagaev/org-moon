class Markdown::List::Parser
  property list : Array(NamedTuple(title: String, description: String))
  property md : String
  class SyntaxError < Exception
  end

  def initialize(@md : String)
    @index = 0
    @list = [] of NamedTuple(title: String, description: String)
  end

  def parse
    lines = @md.lines
    index = 0

    while index < lines.size
      unless lines[index].starts_with?("- ")
        index += 1
        next
      end
      title = lines[index][2..-1].strip
      description = String.build do |builder|
        while (index + 1) < lines.size && !lines[index + 1].starts_with?("- ")
          index += 1
          builder << " " + lines[index].strip
        end
      end
      @list << { title: title, description: description.strip }
      index += 1
    end
    @list
  end
end
