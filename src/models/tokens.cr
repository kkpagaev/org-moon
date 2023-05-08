class Tokens < Granite::Base
  connection pg
  table tokens

  belongs_to :user

  column id : Int64, primary: true
  column refresh_token : String?
  column access_token : String?
  column expires_in : Int32?
  timestamps

  # refreshes the access token
  def access_token_or_refresh_it!
    if last_refresh = updated_at
      if (last_refresh + 1.hour) < Time.utc
        refresh
      end
    end
    access_token
  end

  def refresh
    new_tokens = Google.refresh_tokens(refresh_token)

    update(
      access_token: new_tokens["access_token"],
      expires_in: new_tokens["expires_in"]
    )
  end
end
