class Admin::UsersController < ApplicationController
  def index
    @user = User.page(params[:page]).per(10)
  end

  def show
    @user = User.find(params[:id])
    #レコードを１件だけ取得するのでインスタンス変数名は単数形
    #@articles = @user.articles
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
      render :show
    end
  end

  def user_params
    params.require(:user).permit(
      :name,
      :email,
      :is_deleted,
      :introduction,
      )
  end
end
