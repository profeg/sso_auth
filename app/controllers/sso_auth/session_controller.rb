# frozen_string_literal: true

require_dependency 'sso_auth/application_controller'
require_dependency 'sso_auth/helpers'
require_dependency 'sso_auth/session'

module SsoAuth
  class SessionController < ApplicationController
    include SsoAuth::Helpers
    def index
      redirect_to session_path unless trusted_payload?
      params[:redirect_to] = request.referer&.chomp || session_path
    end

    def create
      user = user_model.find_by(email: user_params['email'], approved: true)

      if user && check_auth(user)
        session_params = new_session_params(user)
        session = SsoAuth::Session.new(session_params)
        redirect_to session.client_sso_url
      else
        redirect_to session_path
      end
    end

    def delete; end

    private

    def user_model
      SsoAuth::Configuration.sso_user.constantize
    end

    def new_session_params(user)
      {}.tap do |p|
        p[:sso]         = params[:sso]
        p[:redirect_to] = params[:redirect_to]
        p[:user]        = user
      end
    end

    def check_auth(user)
      return false unless user&.valid_password?(user_params['password'])
      true
    end

    def user_params
      params.require(:user)
    end

    def trusted_payload?
      return false if params[:sso].blank? || params[:sig].blank?
      sso_sign(params[:sso]) == params[:sig]
    end

  end
end
