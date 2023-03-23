require "./spec_helper"
require "../../src/models/event.cr"

describe Event do
  it "should be able to create an event" do
    date = "22.02.2022"
    start = "8:30"
    finish = "9:30"

    date = "22.02.2022"
    start_at = Time.parse( date + " " + start, "%d.%m.%Y %H:%M", Time::Location::UTC)
    end_at = Time.parse( date + " " + finish, "%d.%m.%Y %H:%M",Time::Location::UTC)

    e = Event.new(title: "Test Event", description:  "This is a test event", start_at: start_at , end_at: end_at )

    e.save.should eq true
    e.errors.should eq [] of String
  end

  it "should be able to bulk create events" do
    date = "22.02.2022"
    start = "8:30"
    finish = "9:30"

    start_at = Time.parse( date + " " + start, "%d.%m.%Y %H:%M", Time::Location::UTC)
    end_at = Time.parse( date + " " + finish, "%d.%m.%Y %H:%M",Time::Location::UTC)

    e = Event.new(title: "Test Event", description:  "This is a test event", start: "8:30" , finish: "9:30", date: "22.02.2022" )

    e.save.should eq true
    e.errors.should eq [] of String

    e = Event.new(title: "Test Event", description:  "This is a test event", start_at: start_at , end_at: end_at )

    e.save.should eq true
    e.errors.should eq [] of String
  end

  it "should create task event(without end_at)" do
    date = "22.02.2022"
    start = "8:30"

    e = Event.new(title: "Test Event", description:  "This is a test event",date: date, start: start, finish: nil )

    e.save.should eq true
    e.errors.should eq [] of String
  end

  it "should not create event when start_at is after end_at" do
    date = "22.02.2022"
    start = "8:30"
    finish = "9:30"

    start_at = Time.parse( date + " " + start, "%d.%m.%Y %H:%M", Time::Location::UTC)
    end_at = Time.parse( date + " " + finish, "%d.%m.%Y %H:%M",Time::Location::UTC)

    e = Event.new(title: "Test Event", description:  "This is a test event", start_at: end_at , end_at: start_at )

    e.save.should eq false
  end
end
