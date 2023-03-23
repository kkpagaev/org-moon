require "jasper_helpers"

class ApplicationController < Amber::Controller::Base
  include JasperHelpers
  LAYOUT = "application.slang"

  def current_user
    context.current_user
  end

  def current_books
    books = Book.all
  end

  def is_api_request?
    context.request.headers["Content-Type"] == "application/json"
  end
end
