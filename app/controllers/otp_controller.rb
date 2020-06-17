class OtpController < ApplicationController
  before_action :authenticate_user!

  def create
    if current_user.otp_enabled?
      flash[:alert] = '2FA is already enabled'
    else
      current_user.enable_otp!
    end

    redirect_to otp_show_path
  end

  def show; end

  def verify
    if current_user.otp_verify?(params.dig(:user, :otp))
      redirect_to(edit_user_registration_path, notice: '2FA has been enabled') && return
    else
      flash.now[:alert] = 'Incorrect code'
    end
    render 'show'
  end

  def delete
    if current_user.otp_enabled?
      current_user.disable_otp!
      flash[:notice] = '2FA has been disabled'
    end
    redirect_to(edit_user_registration_path)
  end
end
