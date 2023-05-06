class Tokens < Granite::Base
  connection pg
  table tokens

  belongs_to :user

  column id : Int64, primary: true
  column refresh_token : String?
  column access_token : String?
  column expires_in : Int32?
  timestamps
end
