require "spec"
require "../../src/markdown/parser.cr"

describe MarkdownParser do
  describe "#tags" do
    it "should return an array of tags" do
      parser = MarkdownParser.new "#hello"
      parser.tags(0).should eq ["hello"]
    end

    it "should return an array of tags" do
      parser = MarkdownParser.new "#hello #world"
      parser.tags(0).should eq ["hello", "world"]
    end

    it "should if there are no tags" do
      parser = MarkdownParser.new "hello world"
      parser.tags(0).should eq [] of String
    end

    it "should return an array of tags" do
      parser = MarkdownParser.new "#hello   #world"
      parser.tags(0).should eq ["hello", "world"]
    end

    it "should return an array of tags" do
      parser = MarkdownParser.new "#hello #world #"
      parser.tags(0).should eq ["hello", "world"]
    end

    it "should return an array of tags" do
      parser = MarkdownParser.new "#hello #world # test"
      parser.tags(0).should eq ["hello", "world"]
    end
  end

  describe "#calendar" do
    it "should parse calendar" do
      text = <<-MARKDOWN 
      # 22.12.2022  
      #Monday  

      - 8:30 - 9:30 Breakfast  

      description foo
      MARKDOWN

      parser = MarkdownParser.new text
      events =[
        Markdown::Event.new(
          title: "Breakfast",
          description: "description foo",
          start_at: Time.utc(2022, 12, 22, 8, 30),
          end_at: Time.utc(2022, 12, 22, 9, 30),
        )
      ]
      title = "22.12.2022"
      tags = ["Monday"]

      res = parser.parse_day("22.12.2022")
      res.title.should eq title
      res.tags.should eq tags
      res.events.should eq events
    end
  end
end
