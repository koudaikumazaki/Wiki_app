# frozen_string_literal: true

class ArticlesController < ApplicationController
  before_action :article, only: %i[search show edit update destroy]

  def index
    @articles = Article.all
  end

  def search
    @page = WikipediaSearch.new(keyword: params[:keyword]).result
    if !@page.text.nil?
      @text = WikiCloth::Parser.new(data: @page.text).to_html
      @sanitize_text = Sanitize.clean(@text)
    else
      redirect_to root_path, alert: '該当する記事は見つかりませんでした。'
    end
  end

  def create
    article.assign_attributes(article_params)
    if article.save
      redirect_to articles_path, notice: '記事を保存しました。'
    else
      redirect_back fallback_location: { action: 'search' }, alert: '記事の保存に失敗しました。'
    end
  end

  def show; end

  def edit; end

  def update
    article.assign_attributes(article_params)
    if article.save
      redirect_to article_path(params[:id]), notice: '記事を更新しました。'
    else
      redirect_back fallback_location: { action: 'show' }, alert: '記事の更新に失敗しました。'
    end
  end

  def destroy
    article.delete
    flash[:notice] = "#{@article.title}の記事を削除しました。"
    redirect_to articles_path
  end

  private

  def article_params
    params.require(:article).permit(:title, :url, :content)
  end

  def article
    @article ||= Article.find_or_initialize_by(id: params[:id])
  end
end
