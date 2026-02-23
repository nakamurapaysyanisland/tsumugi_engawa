class ApplicationController < ActionController::Base
 before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!
 def after_sign_in_path_for(resource)
    mypage_path(resource)
   end

 def after_sign_out_path_for(resource)
    root_path
 end
 
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:last_name, :first_name, :nickname])
  end

end
