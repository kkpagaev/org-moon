require "crypto/bcrypt/password"

class User < Granite::Base
  include Crypto
  connection pg
  table users

  has_many books : Book, foreign_key: :user_id
  has_many notes : Note, foreign_key: :user_id

  has_one tokens : Tokens, foreign_key: :user_id

  column id : Int64, primary: true
  column email : String?
  column hashed_password : String?
  timestamps

  validate :email, "is required", ->(user : User) do
    (email = user.email) ? !email.empty? : false
  end

  validate :email, "already in use", ->(user : User) do
    existing = User.find_by email: user.email
    !existing || existing.id == user.id
  end

  validate :password, "is too short", ->(user : User) do
    user.password_changed? ? user.valid_password_size? : true
  end

  after_save :create_default_books

  def password=(password)
    @new_password = password
    @hashed_password = Bcrypt::Password.create(password, cost: 10).to_s
  end

  def password
    (hash = hashed_password) ? Bcrypt::Password.new(hash) : nil
  end

  def password_changed?
    new_password ? true : false
  end

  def valid_password_size?
    (pass = new_password) ? pass.size >= 8 : false
  end

  def authenticate(password : String)
    (bcrypt_pass = self.password) ? bcrypt_pass.verify(password) : false
  end

  def self.find_or_create!(email : String)
    user = User.find_by email: email
    return user if user
    user = User.new email: email
    user.save!
    user
  end

  private getter new_password : String?

  private def create_default_books
    default = Book.find_or_create_by title: "Default", user_id: id, icon: "gg-calendar-two", is_system: true
    if default.errors.any?
      raise "Could not create default book: #{default.errors}"
      return
    end
    note = Note.new body: "# Whiteboard  \n\n", title: "Whiteboard", user_id: id, book_id: default.id, is_hidden: true
    note.save
    Book.find_or_create_by title: "Calendar", user_id: id, icon: "gg-calendar-today", is_system: true
  end
end
