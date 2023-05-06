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
end
