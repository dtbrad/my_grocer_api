class Api::V1::SessionsController < ApiController
  skip_before_action :authenticate_token

  def login
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      response.headers["jwt"] = Auth.encode(payload: { id: user.id, name: user.name, email: user.email })
      render json: { status: 200, message: ["Login successful!"] }
    else
      render status: 401, json: { message: ["Unable to find a user with that email and password"] }
    end
  end
end
