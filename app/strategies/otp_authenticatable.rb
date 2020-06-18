# frozen_string_literal: true

require 'devise/strategies/authenticatable'

class OtpAuthenticatable < Devise::Strategies::Authenticatable
  # see https://github.com/wardencommunity/warden/wiki/Strategies#authenticate
  def authenticate!
    resource = User.find_by(id: user_id)

    if resource && otp_code && resource.otp_check?(otp_code)
      remember_me(resource)
      resource.after_database_authentication
      success!(resource)
    else
      fail(:invalid_code)
    end
  end

  # see https://github.com/wardencommunity/warden/wiki/Strategies#valid
  def valid?
    user_id.present? && params[:user]&.key?(:otp)
  end

  private

  def user_id
    session[:otp_signin_user_id]
  end

  def otp_code
    @otp_code ||= params.dig(:user, :otp)
  end
end
