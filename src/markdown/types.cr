module Markdown::Page
  class Base
    property title : String?
    property tags : Array(String)

    def initialize(@title, @tags)
    end
  end

  class Day < Base
    getter events : Array(Markdown::Event)

    def initialize(@title, @tags, @events)
    end

    def to_s
      Markdown::Builder::Page.new(title, tags, Markdown::Builder::EventList.new(events)).to_s
    end
  end
end

module Markdown
  struct Event
    property title : String?
    property description : String?

    property start_at : Time?
    property end_at : Time?

    def initialize(@title, @description, @start_at, @end_at)

    end
  end

  struct List
    property title : String?
    property description : String?

    property items : Array(List::Item)

    def initialize(@title, @description, @items)
    end
  end

  struct List::Item
    property title : String?
    property description : String?

    def initialize(@title, @description)
    end
  end
end
