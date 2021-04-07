class Article < ApplicationRecord
  validates :title, presence: true, length: { maximum: 50 }
  validates :url, presence: true, length: { maximum: 100 }, format: /\A#{URI::regexp(%w(http https))}\z/
  validates :content, presence: true
end
