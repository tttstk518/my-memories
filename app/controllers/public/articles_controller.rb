class Public::ArticlesController < ApplicationController

  def new
    @article = Article.new
  end

  def create
    article = Article.new(article_params)
    article.user = current_user
    article.is_deleted = false # 表示／非表示フラグ
    article.star = 0 # レビュー用
    article.save
    redirect_to  articles_path
  end

  def index
    @articles = Article.all
    @genres = Genre.all
  end

  def show
    @article = Article.find(params[:id])
    @genre = Genre.find(params[:id])
  end

  def edit
    @article = Article.find(params[:id])
    @genre = Genre.find(params[:id])
    # 編集リンクから飛んできたときのparamsに格納されたidを元に、該当する投稿データを探して、変数に代入
  end

  def update
    @article = Article.find(params[:id])
    # 編集ページの送信ボタンから飛んできたときのparamsに格納されたidを元に、該当する投稿データを探して、変数に代入
    if @article.update(article_params)
      redirect_to article_path(@article.id)
    else
      render 'edit'
    end
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
      )
  end
end

