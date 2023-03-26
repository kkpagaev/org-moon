require "./types"

module Markdown::Builder
  abstract class Base
    abstract def build : String
  end

  class Page < Base
    property name : String | Nil
    property tags : Array(String)
    property content : Base | String | Nil

    def initialize(@name, @tags, @content)
    end

    def build : String
      String.build do |io|
        if name = @name
          io << "# #{name}  \n"
        end
        io << TagLine.new(tags).build << "\n" unless tags.empty?
        if c = @content
          if c.is_a? Base
            io << c.as(Base).build
          else
            io << c << "  \n"
          end
        end
      end
    end
  end

  class TagLine < Base
    property tags : Array(String)
    def initialize(@tags = [] of String)
    end

    def build : String
      String.build do |io|
        tags.each do |tag|
          io << '#' << tag << ' '
        end
        io << ' '
      end
    end
  end

  class EventList < Base
    property events : Array(Markdown::Event)
    def initialize(@events = [] of Event)
    end

    def build : String
      String.build do |io|
        events.each do |e|
          io << "- "
          if start_at = e.start_at
            io << start_at.to_s "%H:%M"
          end
          if end_at = e.end_at
            io << " - "
            io <<  end_at.to_s "%H:%M"
          end
          if title = e.title
            io << " " << title + "  \n"
          end
          if description = e.description
            io << description + "  \n"
          end
        end
      end
    end
  end
end
