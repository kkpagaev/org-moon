class UserController < ApplicationController
  getter user = User.new

  before_action do
    only [:show, :edit, :update, :destroy] { set_user }
  end

  def me
    current_user.to_json
  end

  def show
    render("show.slang")
  end

  def new
    render "new.slang"
  end

  def edit
    render("edit.slang")
  end

  def create
    user = User.new user_params.validate!
    pass = user_params.validate!["password"]
    user.password = pass if pass

    if user.save
      session[:user_id] = user.id
      redirect_to "/", flash: {"success" => "Created User successfully."}
    else
      flash[:danger] = "Could not create User!"
      render "new.slang"
    end
  end

  def update
    unless params["password"] == params["password_confirmation"]
      flash[:danger] = "Passwords do not match!"
      return render "edit.slang"
    end

    user.password = params["password"]
    if user.save
      redirect_to "/", flash: {"success" => "User has been updated."}
    else
      flash[:danger] = "Could not update User!"
      render "edit.slang"
    end
  end

  def destroy
    user.destroy
    redirect_to "/", flash: {"success" => "User has been deleted."}
  end

  private def user_params
    params.validation do
      required :email
      optional :password
    end
  end

  private def user_update_params
    params.validation do
      required :password
    end
  end

  private def set_user
    @user = current_user.not_nil!
  end
end
