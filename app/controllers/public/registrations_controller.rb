# frozen_string_literal: true

class Public::RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters, if: :devise_controller?

def after_sign_in_path_for(resource)
  if resource.is_a?(Admin)
    admin_dashboard_path
  else
    mypage_path
  end
 end

def after_sign_out_path_for(resource_or_scope)
  if resource_or_scope == :admin
    new_admin_session_path
  else
    root_path
  end
end
 def create
    build_resource(sign_up_params)
    resource.save
    yield resource if block_given?
    if resource.persisted?
      
      set_flash_message! :notice, :signed_up
      sign_up(resource_name, resource)
      respond_with resource, location: after_sign_up_path_for(resource)
    else
  
      clean_up_passwords resource
      set_minimum_password_length
      render :new
    end
  end
 
   protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:last_name, :first_name, :nickname])
  end
  def after_sign_up_path_for(resource)
    mypage_path
  end
end
