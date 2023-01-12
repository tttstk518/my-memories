class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  #サインイン後の遷移先を指定する方法
  def after_sign_up_path_for(resource)
      users_top_path(current_user.id)
  end

  def after_sign_in_path_for(resource)
    users_top_path
  end

  private

  def configure_permitted_parameters
    added_attrs = [ :name, :email, :password ]
    devise_parameter_sanitizer.permit(:sign_up,keys:[added_attrs])
    devise_parameter_sanitizer.permit(:sign_in,keys:[:name, :password])
  end

end
