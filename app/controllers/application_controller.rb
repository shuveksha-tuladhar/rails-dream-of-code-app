class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  
  def require_admin
    if session[:role] != 'admin'
      flash[:alert] = 'You do not have access to that page'
      redirect_to root_path
    end
  end
  
  allow_browser versions: :modern
end
