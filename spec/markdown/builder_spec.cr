require "spec"
require "../../src/markdown/parser.cr"

describe Markdown::Builder::TagLine do
  it "should build a tag line" do
    builder = Markdown::Builder::TagLine.new(["foo","bar","baz"])

    builder.build.should eq "#foo #bar #baz  "
  end
end

describe Markdown::Builder::EventList do
  it "should build an one event list" do
    builder = Markdown::Builder::EventList.new([
      Markdown::Event.new(title: "foo", description: "description", start_at: Time.utc(2015, 1, 1, 8, 30), end_at: Time.utc(2015, 1, 1, 9, 30))
    ])

    builder.build.should eq "- 08:30 - 09:30 foo  \ndescription  \n"
  end

  it "should build an event list" do
    builder = Markdown::Builder::EventList.new([
      Markdown::Event.new(title: "foo", description: "description", start_at: Time.utc(2015, 1, 1, 8, 30), end_at: Time.utc(2015, 1, 1, 9, 30)),
      Markdown::Event.new(title: "test", description: nil, start_at: Time.utc(2015, 1, 1, 10, 30), end_at: nil)
    ])

    builder.build.should eq "- 08:30 - 09:30 foo  \ndescription  \n- 10:30 test  \n"
  end
end

describe Markdown::Builder::Page do
  it "should build a page" do
    builder = Markdown::Builder::Page.new("title", ["foo", "bar"], "test")

    builder.build.should eq "# title  \n#foo #bar  \ntest"
  end

  it "should build a page without tags" do
    builder = Markdown::Builder::Page.new("title", [] of String, "test")

    builder.build.should eq "# title  \ntest"
  end

  it "should build a page without content" do
    builder = Markdown::Builder::Page.new("title", ["foo", "bar"], nil)

    builder.build.should eq "# title  \n#foo #bar  \n"
  end

  it "should build a page without tags and content" do
    builder = Markdown::Builder::Page.new("title", [] of String, nil)

    builder.build.should eq "# title  \n"
  end

  it "should build a page without title" do
    builder = Markdown::Builder::Page.new(nil, ["foo", "bar"], "test")

    builder.build.should eq "#foo #bar  \ntest"
  end

  it "should build a page without title and tags" do
    builder = Markdown::Builder::Page.new(nil, [] of String, "test")

    builder.build.should eq "test"
  end

  it "should build a page without title and content" do
    builder = Markdown::Builder::Page.new(nil, ["foo", "bar"], nil)

    builder.build.should eq "#foo #bar  \n"
  end

  it "should build a page without title, tags and content" do
    builder = Markdown::Builder::Page.new(nil, [] of String, nil)

    builder.build.should eq ""
  end

  it "should build a page with event list" do
    list_builder  = Markdown::Builder::EventList.new([
      Markdown::Event.new(title: "foo", description: "description", start_at: Time.utc(2015, 1, 1, 8, 30), end_at: Time.utc(2015, 1, 1, 9, 30)),
      Markdown::Event.new(title: "test", description: nil, start_at: Time.utc(2015, 1, 1, 10, 30), end_at: nil)
    ])

    builder = Markdown::Builder::Page.new("title", ["foo", "bar"], list_builder)

    builder.build.should eq "# title  \n#foo #bar  \n- 08:30 - 09:30 foo  \ndescription  \n- 10:30 test  \n"
  end
end
