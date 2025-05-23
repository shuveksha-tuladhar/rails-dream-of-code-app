class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  helper_method :current_user

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def require_admin
    if session[:role] != 'admin'
      flash[:alert] = 'You do not have access to that page'
      redirect_to root_path
    end
  end

  def require_student
    unless current_user&.role == 'student'
      flash[:alert] = 'You do not have access to that page'
      redirect_to root_path
    end
  end

  def require_mentor
    unless current_user&.role == 'mentor'
      flash[:alert] = 'You do not have access to that page'
      redirect_to root_path
    end
  end
  
  allow_browser versions: :modern
end
