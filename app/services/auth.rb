class Auth
  ALGORITHM = ENV['ALGORITHM']

  def self.encode(payload)
    JWT.encode(
      payload.merge(exp: 30.minutes.from_now.to_i),
      auth_secret,
      ALGORITHM
    )
  end

  def self.decode(token)
    JWT.decode(token, auth_secret, true, algorithm: ALGORITHM).first
  end

  def self.auth_secret
    ENV['AUTH_SECRET']
  end
end
