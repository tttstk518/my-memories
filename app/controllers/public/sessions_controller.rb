# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  # GET /resource/sign_in
  # def new
  #   super
  # end
  #before_action :reject_user, only: [:create]
  protected
  # 会員の論理削除のための記述。退会後は同じアカウントでは利用不可
  def reject_user
    @user = User.find_by(email: params[:user][:email])
    if @user
      if @user.valid_password?(params[:user][:password]) && (@user.is_deleted == false)
        flash[:notice] = "退会済みです。"
        redirect_to new_user_registration_path
      else
        flash[:notice] = "必須項目を入力してください。"
      end
    end
  end
  
  def after_sign_in_path_for(resource)
      users_top_path(current_user.id)
  end

  def guest_sign_in
    user = User.guest
    sign_in user
    redirect_to root_path, notice: 'ゲストユーザーとしてログインしました。'
  end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_in_params
    #nameをストロングパラメータとして設定
    devise_parameter_sanitizer.permit(:sign_in, keys: [:name])
  end
end
