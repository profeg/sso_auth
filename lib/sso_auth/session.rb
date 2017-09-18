# frozen_string_literal: true

require 'sso_auth/helpers'

module SsoAuth
  class Session
    include SsoAuth::Helpers

    def initialize(args = {})
      args.each do |k, v|
        instance_variable_set "@#{k}", v if %i(sso user redirect_to).include?(k)
      end
    end

    def client_sso_url
      url = "#{@redirect_to}/session/sso_login"
      "#{url}#{@redirect_to.include?('?') ? '&' : '?'}#{payload}"
    end

    def payload
      payload = Base64.encode64(unsigned_payload)
      "sso=#{CGI.escape(payload)}&sig=#{sso_sign(payload)}"
    end

    private

    def unsigned_payload
      payload = {}
      payload[:nonce] = decode(@sso)['nonce']
      payload[:email] = @user.email
      payload[:external_id] = @user.id

      Rack::Utils.build_query(payload)
    end
  end
end
