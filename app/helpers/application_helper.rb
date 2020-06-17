module ApplicationHelper
  def on_login_page?
    [new_user_session_path].include?(request.path)
  end
end
