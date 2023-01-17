class Public::UsersController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update, :withdrawal]

  def create
    @article = Article.new(article_params)
    @article.rate = params[:score] # レビュー用
    if @article.save
      redirect_to  users_top_path(current_user.id), notice: "You have created book successfully."
    else
      @articles = Article.all
      render 'index'
    end
  end

  def search
    @genres = Genre.find(params[:genre_id])
    #@keyword = params[:keyword]
    @articles = @genres.articles
    render "index"
  end

  def index
    @user = User.find(params[:id])
    @articles = @user.articles
    @genre = Genre.all

    if params[:latest]
      @articles = current_user.articles.latest
    elsif params[:old]
      @articles = current_user.articles.old
    elsif params[:star_count]
      @articles = current_user.articles.rate_count
    else
      @article = current_user.articles.published
    end
  end

  def favorites
    @user = current_user
    favorite_article_ids = current_user.favorites.pluck(:article_id)
    favorites = Article.where(id: favorite_article_ids)
    @favorites = favorites.page(params[:page]).per(10)

    unless params[:genre_id].blank?
      if params[:latest]
        @articles = favorites.published.where(genre_id: params[:genre_id]).latest
      elsif params[:old]
        @articles = favorites.published.where(genre_id: params[:genre_id]).old
      elsif params[:star_count]
        @articles = favorites.published.where(genre_id: params[:genre_id]).rate_count
      else
        @articles = favorites.published.where(genre_id: params[:genre_id]).published
      end
    else
      if params[:latest]
        @articles = favorites.published.latest
      elsif params[:old]
        @articles = favorites.published.old
      elsif params[:star_count]
        @articles = favorites.published.rate_count
      else
        @articles = favorites.published.published
      end
    end
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
      :is_deleted
      )
  end

  def is_matching_login_user
    if !user_signed_in?||current_user.email=='guest@example.com'
      redirect_to my_page_path
    end
  end

  def article_params
    params.require(:article).permit(
      :title,
      :text,
      :genre_id,
      :image,
      :rate,
      :is_deleted
      )
  end
end
