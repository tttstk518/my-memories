class Admin::GenresController < ApplicationController
  def index
    @genre = Genre.new
    @genres = Genre.all.page(params[:page]).per(5)
  end

  def create
    #データを受け取り新規登録するためのインスタンス作成
    @genre = Genre.new(genre_params)
    #データをデータベースに保存するためのsaveメソッド実行
    @genre.save
    #ジャンル一覧へリダイレクト
    @genres = Genre.all
    redirect_to admin_genres_path
  end

  def edit
    @genre = Genre.find(params[:id])
  end

  def destroy
    @genre = Genre.find(params[:id])
    @genre.destroy
    redirect_to admin_genres_path
  end

  def update
    genre = Genre.find(params[:id])
    genre.update(genre_params)
    @genres = Genre.all
    redirect_to admin_genres_path
  end

  private
  # ストロングパラメータ
  def genre_params
    params.require(:genre).permit(:name)
  end
end

