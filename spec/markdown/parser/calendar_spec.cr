require "spec"
require "../../../src/markdown/parser/calendar"

calendars = [
# ""
 "- 8:30 Breakfast\n",
]
calendars.each do |calendar|
  parser = Markdown::Calendar::Parser.new(calendar)
  syntax_tree = parser.parse
  puts syntax_tree.inspect
end

describe Markdown::Calendar::Parser do
  it "should parse a calendar" do
    calendar = "- 8:30 Breakfast\n"
    parser = Markdown::Calendar::Parser.new(calendar)
    res = [
      Markdown::Calendar::Task.new("8:30", "Breakfast")
    ]
    parser.parse.should eq res
  end
end

