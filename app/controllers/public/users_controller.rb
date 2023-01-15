class Public::UsersController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]

  def index
    @user = User.page(params[:page]).per(10)
    @article = Article.new
  end

  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    @user.update(user_params)
      redirect_to my_page_path
  end

  def check
  end

  def withdrawal
    @user = User.find(params[:id])
    #is_delitedカラムにフラグを立てる（defaulはfalse)
    @user.update(is_deleted: true)
    reset_session
    #ログアウトさせる
    flash[:notice] = "ありがとうございました。またのご利用お待ちしております"
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(
      :name,
      :email,
      :is_deleted,
      :introduction,
      )
  end
  def is_matching_login_user
    user_id = params[:id].to_i
    unless user_id == current_user.id
      redirect_to my_page_path
    end
  end
end
