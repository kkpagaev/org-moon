require "spec"
require "../../../src/markdown/parser/list"

describe Markdown::List::Parser do
  it "should parse a list" do
    markdown = "- one\n- two\n- three"
    parser = Markdown::List::Parser.new(markdown)
    res = [
      {
        :title => "one",
        :description => nil
      },
      {
        :title => "two",
        :description => nil
      },
      {
        :title => "three",
        :description => nil
      }
    ]
    parser.parse.should eq res
  end

  it "should parse with description" do
    markdown = "- one\nfoo bar\ntest  \n lol\n- two"
    parser = Markdown::List::Parser.new(markdown)
    res = [
      {
        :title => "one",
        :description => "foo bar test lol"
      },
      {
        :title => "two",
        :description => nil
      }
    ]
    parser.parse.should eq res
  end

  it "should partse with description and title" do
    markdown = "- one\nfoo bar\ntest  \n lol\n- two\n- three\nfoo bar"
    parser = Markdown::List::Parser.new(markdown)
    res = [
      {
        :title => "one",
        :description => "foo bar test lol"
      },
      {
        :title => "two",
        :description => nil
      },
      {
        :title => "three",
        :description => "foo bar"
      }
    ]
    parser.parse.should eq res
  end
end