class ApplicationController < ActionController::Base

  def after_sign_in_path_for(resource)
    return admin_root_path if current_user.admin?
    root_path
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, notice: exception.message
  end
end