class ApiController < ActionController::API
  before_action :authenticate_token

  private

  def authenticate_token
    payload = Auth.decode(auth_token)["payload"]
    @current_user = User.find(payload["id"])
    response.headers["jwt"] = Auth.encode(payload:
      { id: @current_user.id, name: @current_user.name, email: @current_user.email })
  rescue JWT::ExpiredSignature
    render json: { errors: ["Auth token has expired"] }, status: :unauthorized
  rescue JWT::DecodeError
    render json: { errors: ["Invalid auth token"] }, status: :unauthorized
  end

  def auth_token
    auth_token ||= request.env["HTTP_AUTHORIZATION"]
  end
end
