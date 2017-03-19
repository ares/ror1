class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :set_locale
  before_action :authenticate_user!

  def set_locale
    I18n.locale = :cs
  end

end
