require "./list"
module Markdown::Calendar
  struct Task
    property start : String
    property title : String
    property description : String

    def initialize(@start : String, @title : String, @description : String = "")
    end
  end

  struct Event
    property start : String
    property finish : String
    property title : String
    property description : String

    def initialize(@start : String, @finish : String, @title : String, @description : String = "")
    end
  end

end
class Markdown::Calendar::Parser
  property list : Array(Task | Event)
  property md : String
  class SyntaxError < Exception
  end

  def initialize(@md : String)
    @list = [] of Task | Event
  end

  def parse
    list_parser = Markdown::List::Parser.new(md)
    list = list_parser.parse
    list.each do |item|
      puts item[:title]
      match = item[:title].match(/(\s*(?<start>\d{1,2}:\d{2}))[ ]*-?\s*(?<finish>\d{1,2}:\d{2})?\s+(?<title>(.*)?)/)
      if match.nil?
        raise SyntaxError.new("Invalid syntax for calendar item: #{item}")
      end
      start = match["start"]
      finish = match["finish"]?
      title = match["title"]
      if finish
        @list << Event.new(start, finish, title)
      else
        @list << Task.new(start, title)
      end
    end
    @list
  end
end

