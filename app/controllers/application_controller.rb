class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  #devise利用機能（ユーザ登録ログイン機能)前にprivateメソッド実行

  #サインイン後の遷移先を指定する方法
  def after_sign_up_path_for(resource)
    users_top_path(current_user.id)
  end

  def after_sign_in_path_for(resource)
    users_top_path(current_user.id)
  end

   def ensure_general_user
     if resource.email == "guest@example.com"
       redirect_to root_path, alert: "ゲストユーザーの変更・削除はできません"
     end
   end

  def update_resource(resource, params)
    resource.update_without_password(params)
  end

  private

  def configure_permitted_parameters
    added_attrs = [ :name, :email, :password ]
    devise_parameter_sanitizer.permit(:sign_up,keys:[added_attrs])
    devise_parameter_sanitizer.permit(:sign_in,keys:[:name, :password])
  end


end
