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
      @articles = Article.all
      render 'index'
    end
  end

  def search
    @articles = Article.search(params[:keyword])
    @keyword = params[:keyword]
    render "index"
  end

  def index
    @article = Article.new
    @articles = Article.published
    @genre = Genre.all

    if params[:latest]
      @articles = Article.latest
    elsif params[:old]
      @articles = Article.old
    elsif params[:star_count]
      @articles = Article.rate_count
    else
      @article = Article.published
    end
  end

  def show
    @article = Article.find(params[:id])
  end

  def edit
    @article = Article.find(params[:id])

    @article.rate = params[:score]
    # 編集リンクから飛んできたときのparamsに格納されたidを元に、該当する投稿データを探して、変数に代入
  end

  def update
    @article = Article.find(params[:id])
    @article.rate = params[:score]
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

