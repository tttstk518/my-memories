class Public::FavoritesController < ApplicationController
  before_action :authenticate_user!

  def create
    #article_idを取得してその後user_idにcurrent_userを紐付ける
    @article = Article.find(params[:article_id])
    favorite = @article.favorites.new(user_id: current_user.id)
    if favorite.save
      redirect_to request.referer
    else
      redirect_to request.referer
    end
  end

  def destroy
    @article = Article.find(params[:article_id])
    favorite = @article.favorites.find_by(user_id: current_user.id)
    if favorite.present?
      #favorite二度押しのエラー回避
       favorite.destroy
        redirect_to request.referer
    else
        redirect_to request.referer
    end
  end

  def index
    @favorites = Favorite.where(user_id: current_user.id)
  end

  def show
    @article = Article.find(params[:article_id])
  end
end
