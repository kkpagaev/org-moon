class GoogleController < ApplicationController
  def callback
    # redirect_to "/signin", flash: {"error" => "Failed to Google auth"} unless params[:error]
    code = params[:code]
    code

    responce = Google.exchange_code(code)

    tokens = Tokens.new(responce)

    email = JWT.decode(responce["id_token"].to_s, verify: false, validate: false).first["email"]

    user = User.find_or_create!(email.to_s)
    Tokens.where(user_id: user.id).each { |t| t.destroy }

    tokens.user_id = user.id

    tokens.save!

    session[:user_id] = user.id
    flash[:info] = "Successfully logged in with Google"
    redirect_to "/"
  end

  def test
    if date = params[:date]
      # begin
        day = Day.find_or_initialize_by(date: date, user_id: current_user!.id)
        c = GoogleCalendar.find_or_create(current_user!.id)
        # c.add_event
        ids = c.delete_events(date.day_to_date)
      # rescue e
      #   e.message
      # end
    end
  end
end
