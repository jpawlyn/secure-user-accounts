# frozen_string_literal: true

# see https://github.com/heartcombo/devise#configuring-controllers
class Users::SessionsController < Devise::SessionsController
  prepend_before_action :require_no_authentication, only: [:new, :create, :new_with_otp, :create_with_otp]

  def new_with_otp
    redirect_to(new_user_session_path) && return unless session[:otp_signin_user_id]
  end

  def create_with_otp
    self.resource = warden.authenticate!(auth_options_for_otp)
    set_flash_message!(:notice, :signed_in)
    sign_in(resource_name, resource)
    respond_with resource, location: after_sign_in_path_for(resource)
  end

  protected

  def auth_options_for_otp
    { scope: resource_name, recall: "#{controller_path}#new_with_otp" }
  end
end
