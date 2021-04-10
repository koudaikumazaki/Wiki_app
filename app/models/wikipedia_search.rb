# frozen_string_literal: true

class WikipediaSearch < ApplicationRecord
  def self.result(keyword)
    if keyword != ''
      Wikipedia.find(keyword.to_s)
    else
      Wikipedia.find('.')
    end
  end
end
