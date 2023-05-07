require "./spec_helper"
require "../../src/models/google_calendar.cr"

describe GoogleCalendar do
  Spec.before_each do
    GoogleCalendar.clear
  end
end
