class Public::UsersController < ApplicationController
  # before_action :is_matching_login_user, only: [:edit, :update]

  def index

  end

  def favorites
    @user = current_user
    @favorites = Favorite.where(user_id: current_user.id)
  end

  def show
    @user = current_user
    @article = Article.new
    @favorites = Favorite.where(user_id: current_user.id)
  end

  def edit
    is_matching_login_user
    @user = current_user
  end

  def update
    # is_matching_login_user
    @user = current_user
    if @user.update!(user_params)
      redirect_to my_page_path(@user), notice: "You have updated successfully."
    else
      render 'edit'
    end
  end

  def check
  end

  def destroy
    @user = current_user
    if @user.email == 'guest@example.com'
      reset_session
      redirect_to :root
    else
      @user.update(is_valid: false)
      reset_session
      redirect_to :root
    end
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
