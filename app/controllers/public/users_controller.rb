class Public::UsersController < ApplicationController

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
     @user = current_user
  end

  def withdrawal
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
end
