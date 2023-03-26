require "spec"
require "../../../src/markdown/parser.cr"

describe Markdown::Parser::List do
  it "should parse a list" do
    markdown = "- one\n- two\n- three"
    parser = Markdown::Parser::List.new(markdown)
    parser.parse.should eq [
      Markdown::List::Item.new("one", nil),
      Markdown::List::Item.new("two", nil),
      Markdown::List::Item.new("three", nil)
    ]
  end

  it "should parse with description" do
    markdown = "- one\nfoo bar\ntest  \n lol\n- two"
    parser = Markdown::Parser::List.new(markdown)
    res = [
      Markdown::List::Item.new("one", "foo bar test lol"),
      Markdown::List::Item.new("two", nil)
    ]
    parser.parse.should eq res
  end

  it "should partse with description and title" do
    markdown = "- one\nfoo bar\ntest  \n lol\n- two\n- three\nfoo bar"
    parser = Markdown::Parser::List.new(markdown)
    res = [
      Markdown::List::Item.new("one", "foo bar test lol"),
      Markdown::List::Item.new("two", nil),
      Markdown::List::Item.new("three", "foo bar")
    ]
    parser.parse.should eq res
  end
end
