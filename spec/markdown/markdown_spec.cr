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
end
