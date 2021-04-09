class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end

  def search
    require 'wikipedia'
    if params[:keyword] != ''
      @page = Wikipedia.find(params[:keyword])
      if !@page.text.nil?
        @text = WikiCloth::Parser.new(data: @page.text).to_html
        @sanitize_text = Sanitize.clean(@text)
      else
        redirect_to root_path, alert: '入力したワードは見つかりませんでした。'
      end
    else
      redirect_to root_path, alert: 'フォームが空欄です。'
    end
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      redirect_to articles_path, notice: '記事を保存しました。'
    else
      redirect_back fallback_location: { action: 'search' }, alert: '記事の保存に失敗しました。'
    end
  end

  def show
    @article = Article.find(params[:id])
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    @article.update(article_params)
    if @article.save
      redirect_to article_path(params[:id]), notice: '記事を更新しました。'
    else
      redirect_back fallback_location: { action: 'show' }, alert: '記事の更新に失敗しました。'
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.delete
    flash[:notice] = "#{@article.title}の記事を削除しました。"
    redirect_to articles_path
  end

  private
  def article_params
    params.require(:article).permit(:title, :url, :content)
  end
end