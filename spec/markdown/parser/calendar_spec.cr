require "spec"
require "../../../src/markdown/parser/calendar"

describe Markdown::Calendar::Parser do
  it "should parse Task calendar" do
    calendar = "- 8:30 Breakfast\n"
    parser = Markdown::Calendar::Parser.new(calendar)
    res = [
      {
        :from => "8:30",
        :to => nil,
        :title => "Breakfast",
        :description => nil
      }
    ]
    parser.calendar_list.should eq res
  end

  it "should parse Event calendar" do
    calendar = "- 8:30 - 9:30 Breakfast"
    parser = Markdown::Calendar::Parser.new(calendar)
    res = [
      {
        :from => "8:30",
        :to => "9:30",
        :title => "Breakfast",
        :description => nil
      }
    ]
    parser.calendar_list.should eq res
  end

  it "should parse with description" do
    calendar = "- 8:30 - 9:30 Breakfast\n  Eat eggs"
    parser = Markdown::Calendar::Parser.new(calendar)
    res = [
      {
        :from => "8:30",
        :to => "9:30",
        :title => "Breakfast",
        :description => "Eat eggs"
      }
    ]
    parser.calendar_list.should eq res
  end
end

