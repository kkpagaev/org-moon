require "jasper_helpers"

class ApplicationController < Amber::Controller::Base
  include JasperHelpers
  LAYOUT = "application.slang"

  getter book = Book.new

  def current_user
    context.current_user
  end

  def current_user!
    current_user || raise "Authentication required"
  end

  def current_books
    if user = current_user
      user.books.select { |book| !book.is_system && !book.is_hidden }
    else
      [] of Book
    end
  end

  def is_api_request?
    context.request.headers["Content-Type"] == "application/json"
  end
end
