class Public::ArticlesController < ApplicationController

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.user_id = current_user.id
    # @article.is_deleted = false # 表示／非表示フラグ
    @article.rate = params[:score] # レビュー用
    if @article.save
      redirect_to  articles_path(@article), notice: "You have created book successfully."
    else
      render :new
    end
  end

  def search
    @genres = Genre.find(params[:genre_id])
    #@keyword = params[:keyword]

    if params[:latest]
      @articles = @genres.articles.latest
    elsif params[:old]
      @articles = @genres.articles.old
    elsif params[:star_count]
      @articles = @genres.articles.rate_count
    else
      @articles = @genres.articles.published
    end

    render "index"
  end

  def index
    @article = Article.new
    @articles = Article.published
    @genre = Genre.all

    unless params[:genre_id].blank?
      @genres = Genre.find(params[:genre_id])
      if params[:latest]
        @articles = @genres.articles.published.latest
      elsif params[:old]
        @articles = @genres.articles.published.old
      elsif params[:star_count]
        @articles = @genres.articles.published.rate_count
      else
        @articles = @genres.articles.published.published
      end
    else
      if params[:latest]
        @articles = Article.published.latest
      elsif params[:old]
        @articles = Article.old
      elsif params[:star_count]
        @articles = Article.published.rate_count
      else
        @articles = Article.published.published
      end
    end
  end

  def show
    @article = Article.find(params[:id])
  end

  def edit
    @article = Article.find(params[:id])

    # @article.rate = params[:score]
    # 編集リンクから飛んできたときのparamsに格納されたidを元に、該当する投稿データを探して、変数に代入
  end

  def update
    @article = Article.find(params[:id])
    # @article.rate = params[:score]
    # 編集ページの送信ボタンから飛んできたときのparamsに格納されたidを元に、該当する投稿データを探して、変数に代入
    if @article.update(article_params)
      redirect_to article_path(@article.id),notice: "You have updated book successfully."
    else
      render 'edit'
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to articles_path
  end

  private
  # ストロングパラメータ
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

