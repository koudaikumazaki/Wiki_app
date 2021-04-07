class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end

  def search
    require 'wikipedia'
    if params[:keyword]
      @page = Wikipedia.find(params[:keyword])
      @text = WikiCloth::Parser.new(data: @page.text).to_html
      @sanitize_text = Sanitize.clean(@text)
    else
      @page = Wikipedia.find('.')
    end
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      redirect_to root_path, notice: '記事を保存しました。'
    else
      redirect_back fallback_location: { action: 'search' }, alert: '記事の保存に失敗しました。'
    end
  end

  private
  def article_params
    params.require(:article).permit(:title, :url, :content)
  end
end