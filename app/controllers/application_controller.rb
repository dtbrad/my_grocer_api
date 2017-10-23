class ApplicationController < ActionController::API
  before_action :authenticate_token!
  attr_reader :current_user

  private

  def authenticate_token!
    payload = Auth.decode(auth_token)
    return unless @current_user = User.find(payload["user"])
    response.headers["jwt"] = Auth.encode(user: @current_user.id)
    response.headers["user_id"] = Auth.encode(user: @current_user.id)
    response.headers["user_name"] = Auth.encode(user: @current_user.name)
    response.headers["user_email"] = Auth.encode(user: @current_user.email)
  end

  def auth_token
    @auth_token ||= request.env["HTTP_AUTHORIZATION"]
  end
end
