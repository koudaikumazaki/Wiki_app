# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Article, type: :model do
  let(:article) { build(:article) }

  it 'title,url,contentが正しい値で存在すれば有効な状態であること' do
    expect(article).to be_valid
  end

  describe 'title関連のバリデーション' do
    it { should validate_length_of(:title).is_at_most(50) }
    it { should validate_presence_of(:title) }
  end

  describe 'url関連のバリデーション' do
    it { should validate_length_of(:url).is_at_most(100) }
    it { should validate_presence_of(:url) }
    it { should allow_value('https://foo.com').for(:url) }
  end

  describe 'content関連のバリデーション' do
    it { should validate_presence_of(:content) }
  end
end
