require "spec"
require "../../../src/markdown/parser/calendar"

describe Markdown::Calendar::Parser do
  it "should parse a calendar" do
    calendar = "- 8:30 Breakfast\n"
    parser = Markdown::Calendar::Parser.new(calendar)
    res = [
      {
        :from => "8:30",
        :to => nil,
        :title => "Breakfast"
      }
    ]
    parser.calendar_list.should eq res
  end
end

