class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  before_action :set_current_user
  allow_browser versions: :modern

  private
    # setting up the current user, don't need this after authentication
    def set_current_user
      @current_user = User.first
    end
end
