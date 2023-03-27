require "spec"
require "../../../src/markdown/parser.cr"

describe Markdown::Parser::Calendar do
  it "should parse Task calendar" do
    calendar = "- 8:30 Breakfast\n"
    parser = Markdown::Parser::Calendar.new(calendar)
    res = [
      Markdown::Event.new(
        start_at: Time.utc(2015, 1, 1, 8, 30),
        end_at: nil,
        title: "Breakfast",
        description: nil,
      ),
    ]
    parser.calendar_list("1.1.2015").should eq res
  end

  it "should parse Event calendar" do
    calendar = "- 8:30 - 9:30 Breakfast"
    parser = Markdown::Parser::Calendar.new(calendar)
    res = [
      Markdown::Event.new(
        start_at: Time.utc(2015, 1, 1, 8, 30),
        end_at: Time.utc(2015, 1, 1, 9, 30),
        title: "Breakfast",
        description: nil,
      ),
    ]
    parser.calendar_list("1.1.2015").should eq res
  end

  it "should parse with description" do
    calendar = "- 8:30 - 9:30 Breakfast\n  Eat eggs"
    parser = Markdown::Parser::Calendar.new(calendar)

    res = parser.calendar_list("1.1.2015")
    res.size.should eq 1
    e = res[0]
    e.start_at.should eq Time.utc(2015, 1, 1, 8, 30)
    e.end_at.should eq Time.utc(2015, 1, 1, 9, 30)
    e.title.should eq "Breakfast"
    e.description.should eq "Eat eggs"
  end
end
