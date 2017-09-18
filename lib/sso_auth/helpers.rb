module SsoAuth
  module Helpers
    def decode(payload)
      Rack::Utils.parse_query(Base64.decode64(payload))
    end

    def sso_sign(payload)
      OpenSSL::HMAC.hexdigest('sha256', SsoAuth::Configuration.sso_secret, payload)
    end
  end
end
