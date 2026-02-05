class ApplicationController < ActionController::Base
 before_action :configure_permitted_parameters, if: :devise_controller?


 def after_sign_put_path_for(resource)
    root_path
 end
 
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:last_name, :first_name, :nickname])
  end

end
