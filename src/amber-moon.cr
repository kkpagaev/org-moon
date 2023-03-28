require "../config/application"

require "moon-markdown"

Amber::Support::ClientReload.new if Amber.settings.auto_reload?
Amber::Server.start
