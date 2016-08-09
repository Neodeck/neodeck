class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user, :validate_logged_in
  before_filter :init_og_tags
  before_action :set_locale

  def set_locale
    I18n.locale = session[:locale] || I18n.default_locale
  end

  def init_og_tags
    @open_graph = []
  end

  def current_user
    if session[:current_user_id]
      User.find(session[:current_user_id])
    else
      nil
    end
  end

  def validate_logged_in
    unless current_user
      redirect_to auth_path(:then => request.path)
    end
  end
end
