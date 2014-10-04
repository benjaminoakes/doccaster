class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  force_ssl if: :force_ssl?
  http_basic_authenticate_with name: ENV['DOCCASTER_AUTH_NAME'], password: ENV['DOCCASTER_AUTH_PASSWORD']

  private

  def force_ssl?
    Rails.env.production? && !request.user_agent.match('TinyTinyNAS')
  end
end
