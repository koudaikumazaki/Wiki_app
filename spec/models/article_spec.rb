require 'rails_helper'

RSpec.describe Article, type: :model do
  let(:article) { build(:article) }

  it 'title,url,contentが正しい値で存在すれば有効な状態であること' do
    expect(article).to be_valid
  end

  describe 'title関連のバリデーション' do
    it 'titleが存在しない時、無効な状態であること' do
      article.title = nil
      expect(article).to be_invalid
    end
    it 'titleが51文字以上の時、無効な状態であること' do
      article.title = 'a' * 51
      expect(article).to be_invalid
    end
    it 'titleが50文字以下の時、有効な状態であること' do
      article.title = 'a' * 50
      expect(article).to be_valid
    end
  end

  describe 'url関連のバリデーション' do
    it 'urlが存在しない時、無効な状態であること' do
      article.url = nil
      expect(article).to be_invalid
    end
    it 'urlが101文字以上の時、無効な状態であること' do
      article.url = "https://#{'a' * 89}.com"
      expect(article).to be_invalid
    end
    it 'urlが100文字以下の時、有効な状態であること' do
      article.url = "https://#{'a' * 88}.com"
      expect(article).to be_valid
    end
    it { should allow_value('https://foo.com').for(:url) }
  end

  describe 'content関連のバリデーション' do
    it 'titleが存在しない時、無効な状態であること' do
      article.content = nil
      expect(article).to be_invalid
    end
  end
end
