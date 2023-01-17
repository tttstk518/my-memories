class Admin::UsersController < ApplicationController

  def index
    @users = User.page(params[:page]).per(5)
  end

  def show
    @user = User.find(params[:id])
    #レコードを１件だけ取得するのでインスタンス変数名は単数形
    #アソシエーションを持つモデル同士の既述
  end

  def edit
     @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admin_user_path(@user.id)
    else
      render 'index'
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :name,
      :email,
      :is_deleted,
      )
  end
end
