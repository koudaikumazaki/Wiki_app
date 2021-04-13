# frozen_string_literal: true

require 'rails_helper'

RSpec.describe WikipediaSearch, type: :model do
  describe 'resultメソッドのテスト' do
    let(:wikipedia_search) { build(:wikipedia_search) }
    context 'keywordが存在する場合' do
      it '検索後のtitleに適切なタイトル名が入っていること' do
        expect(wikipedia_search.result.title).to eq 'リンゴ'
      end
    end
    context 'keywordが存在しない場合' do
      it '検索後のtitleに適切なタイトル名が入っていること' do
        wikipedia_search.keyword = ''
        expect(wikipedia_search.result.title).to eq '.'
      end
    end
  end
end
