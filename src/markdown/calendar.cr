module Markdown
  class Task
    property start : String
    property title : String
    property description : String

    def initialize(@start : String, @title : String, @description : String = "")
    end
  end

  class Event
    property start : String
    property finish : String
    property title : String
    property description : String

    def initialize(@start : String, @finish : String, @title : String, @description : String = "")
    end
  end

  class Calendar
    property list : Array(Task | Event)
    property date : String

    def initialize(@list : Array(Task | Event), @date : String)
    end
  end
end
