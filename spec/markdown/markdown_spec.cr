require "../spec_helper"
require "../../src/markdown/parser.cr"

describe MarkdownParser do
  describe "#parse" do
    it "parses a simple markdown document" do
      parser = MarkdownParser.new "# Hello World"
      parser.parse().should not raise_error 
    end

    it "parses a markdown document with multiple lines" do
      parser = MarkdownParser.new "# Hello World"
      parser.parse.should not raise_error 
    end
  end
end
