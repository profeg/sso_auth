module SsoAuth
  module Helpers
    def decode(payload)
      Rack::Utils.parse_query(Base64.decode64(payload))
    end

    def sign(payload)
      OpenSSL::HMAC.hexdigest('sha256', ENV['SSO_SECRET_KEY'], payload)
    end
  end
end
