class Api::V1::SessionsController < ApplicationController
  skip_before_action :authenticate_token!

  def login
    user = User.find_by(email: params[:user][:email])
    if user && user.authenticate(params[:user][:password])
      response.headers["jwt"] = Auth.encode(user: user.id)
      render json: { status: 200, message: ["Login successful!"] }
    else
      render status: 401, json: { message: ["Unable to find a user with that email and password"] }
    end
  end
end
