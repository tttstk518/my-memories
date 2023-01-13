class Public::ArticlesController < ApplicationController

  def new
    @article = Article.new
  end

  def create
    article = Article.new(article_params)
    article.save
    redirect_to  articles_path
  end

  def index
    @articles = Article.all
  end

  def show
  end

  def edit
    @article = Article.find(params[:id])
    if @article.update(article_params)
      redirect_to article_path, notice: "編集しました"
    else
      flas.now[:danger] = "編集に失敗しました"
      render 'edit'
    end
  end

  def update
  end
  private
  # ストロングパラメータ
  def article_params
    params.permit(
      :title,
      :text,
      :image,
      )
  end
  #def article_params
   # { article_id: params[:article_id]}
  #end
end

