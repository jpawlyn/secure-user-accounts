module ApplicationHelper
  def on_login_page?
    [new_user_session_path, users_sign_in_otp_path].include?(request.path)
  end
end
