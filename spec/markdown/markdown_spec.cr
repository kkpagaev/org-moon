require "spec"
require "../../src/markdown/parser.cr"

describe MarkdownParser do
  describe "#calendar" do
    it "should parse a calendar" do
      markdown = <<-MARKDOWN
- 8:00 Breakfast
- 9:00 Meeting
MARKDOWN
      parser = MarkdownParser.new markdown

      parser.calendar(0).should eq [
        CalendarEvent.new("8:00", "Breakfast"),
        CalendarEvent.new("9:00", "Meeting")
      ]
    end

    it "with title" do
      markdown = <<-MARKDOWN
      - 8:00 Breakfast
      - 9:00 - 10:10 Meeting
      MARKDOWN

      parser = MarkdownParser.new markdown

      parser.calendar(0).should eq [
        CalendarEvent.new("8:00", "Breakfast"),
        CalendarTask.new("9:00", "10:10", "Meeting")
      ]
    end

    it "with description" do
      markdown = <<-MARKDOWN
      - 8:00 Breakfast
      - 9:00 - 10:10 Meeting  
      test
      MARKDOWN

      parser = MarkdownParser.new markdown

      parser.calendar(0).should eq [
        CalendarEvent.new("8:00", "Breakfast"),
        CalendarTask.new("9:00", "10:10", "Meeting", "test")
      ]
    end
  end
end
