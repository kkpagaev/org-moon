require "./config/application"

date = "22.02.2022"
start = "8:30"

e = Event.new(title: "Test Event", description:  "This is a test event", start: start )


puts e.save
puts e.errors
