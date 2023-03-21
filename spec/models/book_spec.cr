require "./spec_helper"
require "../../src/models/book.cr"

describe Book do
  Spec.before_each do
    Book.clear
  end
end
