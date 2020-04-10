class ApplicationController < ActionController::Base
  before_action :set_locale
  include SessionsHelper
  def logged_in_user
    return if logged_in?
    store_location
    flash[:danger] = t "controller.user.not_login"
    redirect_to login_url
  end
  private

  def set_locale
    locale = params[:locale].to_s.strip.to_sym
    if I18n.available_locales.include? locale
      I18n.locale = locale
    elsif I18n.locale = I18n.default_locale
    end
  end

  def default_url_options
    {locale: I18n.locale}
  end
end
