class Admin::HomesController < ApplicationController
  def top
    @articles = Article.page(params[:page]).per(10)
    @genre = Genre.all
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :is_deleted)
  end

end
