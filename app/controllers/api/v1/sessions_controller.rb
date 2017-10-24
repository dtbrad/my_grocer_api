class Api::V1::SessionsController < ApiController
  skip_before_action :authenticate_token!

  def login
    user = User.find_by(email: params[:user][:email])
    if user && user.authenticate(params[:user][:password])
      response.headers["jwt"] = Auth.encode(user: user.id)
      response.headers["user_id"] = user.id
      response.headers["user_name"] = user.name
      response.headers["user_email"] = user.email
      render json: { status: 200, message: ["Login successful!"] }
    else
      render status: 401, json: { message: ["Unable to find a user with that email and password"] }
    end
  end
end
