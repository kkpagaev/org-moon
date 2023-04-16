class SessionController < ApplicationController
  def new
    user = User.new
    render("new.slang")
  end

  def create
    user = User.find_by(email: params["email"].to_s)
    if user && user.authenticate(params["password"].to_s)
      session[:user_id] = user.id
      flash[:info] = "Successfully logged in"
      redirect_to "/"
    else
      flash[:danger] = "Invalid email or password"
      user = User.new
      render("new.slang")
    end
  end

  def delete
    session.delete(:user_id)
    flash[:info] = "Logged out. See ya later!"
    redirect_to "/"
  end

  def create_api
    user = User.find_by(email: params["email"].to_s)
    if user && user.authenticate(params["password"].to_s)
      # todo make it into config file
      token = JWT.encode({"user_id" => user.id}, "SecretKey", JWT::Algorithm::HS256)
      {token: token}.to_json
    else
      {error: "Invalid email or password"}.to_json
    end
  end
end
