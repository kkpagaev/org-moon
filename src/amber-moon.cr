require "moon-markdown"
require "crest"

require "./google/*"

require "../config/application"
require "./markdown"

Amber::Support::ClientReload.new if Amber.settings.auto_reload?
Amber::Server.start
