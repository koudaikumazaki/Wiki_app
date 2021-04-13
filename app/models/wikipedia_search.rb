# frozen_string_literal: true

class WikipediaSearch
  include ActiveModel::Model

  attr_accessor :keyword

  def result
    if keyword != ''
      Wikipedia.find(keyword.to_s)
    else
      Wikipedia.find('.')
    end
  end
end
