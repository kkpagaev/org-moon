class GoogleController < ApplicationController
  def callback
    # redirect_to "/signin", flash: {"error" => "Failed to Google auth"} unless params[:error]
    code = params[:code]
    code

    responce = Google.exchange_code(code)
  end
end
