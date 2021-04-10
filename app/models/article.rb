# frozen_string_literal: true

class Article < ApplicationRecord
  validates :title, presence: true, length: { maximum: 50 }
  validates :url, presence: true, length: { maximum: 100 },
                  format: /\A#{URI::DEFAULT_PARSER.make_regexp(%w[http https])}\z/
  validates :content, presence: true
end
