require "./list"
require "../calendar"

class Markdown::Calendar::Parser
  property list : Array(Hash(Symbol, String | Nil))
  property md : String
  class SyntaxError < Exception
  end

  def initialize(@md : String)
    @list = [] of Hash(Symbol, String | Nil)
  end

  def calendar_list
    list_parser = Markdown::List::Parser.new(md)
    list = list_parser.parse
    list.each do |item|
      title = item[:title]
      next if title.nil?
      match = title.match(/(\s*(?<start>\d{1,2}:\d{2}))[ ]*-?\s*(?<finish>\d{1,2}:\d{2})?\s+(?<title>(.*)?)/)
      if match.nil?
        raise SyntaxError.new("Invalid syntax for calendar item: #{item}")
      end
      @list << {
        :from => match["start"],
        :to => match["finish"]?,
        :title => match["title"],
        :description => item[:description]?,
      }
    end
    @list
  end
end

