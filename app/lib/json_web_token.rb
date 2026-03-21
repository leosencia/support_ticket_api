class JsonWebToken
  SECRET_KEY = Rails.application.credentials.jwt_secret_key

  def self.encode(payload, exp = 24.hours.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload, SECRET_KEY)
  end

  def self.decode(token)
    decoded = JWT.decode(token, SECRET_KEY)[0]
    HashWithIndifferentAccess.new(decoded)
  rescue JWT::ExpiredSignature
    raise GraphQL::ExecutionError, "Token has expired, please log in again"
  rescue JWT::DecodeError
    raise GraphQL::ExecutionError, "Invalid token"
  end
end
