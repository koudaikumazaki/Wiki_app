# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Articles', type: :request do
  # let!(:article) { create(:article) }
  let(:article_params) { attributes_for(:article) }
  let(:new_article_params) { attributes_for(:article, title: 'after_update') }
  let(:invalid_article_params) { attributes_for(:article, title: nil) }

  describe 'GET /home' do
    it '正常にレスポンスを返すこと' do
      get root_path
      expect(response).to have_http_status(200)
      expect(response.body).to include '記事の検索画面'
    end
  end

  describe 'GET /index' do
    it '正常にレスポンスを返すこと' do
      get articles_path
      expect(response).to have_http_status(200)
      expect(response.body).to include '保存した記事一覧'
    end
  end

  describe 'GET /show' do
    it '正常にレスポンスを返すこと' do
      get article_path(article)
      expect(response).to have_http_status(200)
      expect(response.body).to include article.title.to_s
    end
  end

  describe 'GET /search' do
    context 'フォーム内の値が有効でWikipedia内に記事があった場合' do
      it '記事を表示する' do
        get search_path, params: { keyword: 'りんご' }
        expect(response).to have_http_status(200)
      end
    end
    context 'フォーム内の値が有効でWikipedia内に記事が存在しない場合' do
      it 'ホーム画面にリダイレクトされる' do
        get search_path, params: { keyword: 'gnaogjdsgpj' }
        expect(response).to redirect_to root_path
      end
    end
    context 'フォーム内の値が空欄の場合' do
      it 'ホーム画面にリダイレクトされる' do
        get search_path, params: { keyword: '' }
        expect(response).to redirect_to root_path
      end
    end
  end

  describe 'POST /create' do
    let(:article) { create(:article) }
    let(:article_params) { attributes_for(:article) }
    context 'フォーム値が有効な場合' do
      it '投稿が成功する' do
        expect do
          post search_url, params: { article: article_params }
          # end.to change(Article, :count).from(0).to(1)
        end.to change(Article, :count).by(1)
      end
      it '保存した記事一覧画面にリダイレクトされる' do
        post search_url, params: { article: article_params }
        expect(response).to redirect_to articles_path
      end
    end
    context 'フォーム値が無効な場合' do
      it '投稿が失敗する' do
        expect do
          post search_url, params: { article: invalid_article_params }
        end.to_not change(Article, :count)
      end
      it '/articles/searchにリダイレクトされる' do
        post search_url, params: { article: invalid_article_params }
        expect(response).to have_http_status(302)
      end
    end
  end

  describe 'GET /edit' do
    it '正常にレスポンスを返すこと' do
      get edit_article_path(article)
      expect(response).to have_http_status(200)
      expect(response.body).to include '保存した記事を編集する'
    end
  end

  describe 'PATCH /update' do
    context '更新内容が有効な場合' do
      it '更新が成功する' do
        patch article_path(article), params: { article: new_article_params }
        article.reload
        expect(article.title).to eq 'after_update'
      end
      it '記事の詳細画面にリダイレクトする' do
        patch article_path(article), params: { article: new_article_params }
        expect(response).to redirect_to article_path(article)
      end
    end
    context '更新内容が無効な場合' do
      it '更新が失敗する' do
        patch article_path(article), params: { article: invalid_article_params }
      end
      it '編集画面にリダイレクトされる' do
        patch article_path(article), params: { article: invalid_article_params }
        expect(response).to redirect_to("/articles/#{article.id}")
      end
    end
  end

  describe 'DELETE /destroy' do
    it '記事の削除に成功する' do
      expect do
        delete article_path(article)
      end.to change(Article, :count).by(-1)
    end
    it '保存した記事一覧画面にリダイレクトする' do
      delete article_path(article)
      expect(response).to redirect_to articles_path
    end
  end
end
