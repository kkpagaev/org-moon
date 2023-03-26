require "./page"

class Markdown::Parser::Calendar < Markdown::Parser::Page
  property list : Array(Markdown::Event) = [] of Event

  class SyntaxError < Exception
  end


  def calendar_list(date : String) : Array(Markdown::Event)
    list_parser = Markdown::Parser::List.new(md)
    list = list_parser.parse
    list.each do |item|
      title = item.title
      next if title.nil?
      match = title.match(/(\s*(?<start>\d{1,2}:\d{2}))[ ]*-?\s*(?<finish>\d{1,2}:\d{2})?\s+(?<title>(.*)?)/)
      if match.nil?
        raise SyntaxError.new("Invalid syntax for calendar item: #{item}")
      end

      start_at = Time.parse( date + " " + match["start"], "%d.%m.%Y %H:%M", Time::Location::UTC)
      if finish = match["finish"]?
        end_at = Time.parse( date + " " + finish, "%d.%m.%Y %H:%M",Time::Location::UTC)
      end

      @list << Markdown::Event.new(
        start_at: start_at,
        end_at: end_at,
        title: match["title"],
        description: item.description,
      )
    end
    @list
  end
end

