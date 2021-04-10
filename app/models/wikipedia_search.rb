class WikipediaSearch < ApplicationRecord
  def self.result(keyword)
    if keyword != ''
      Wikipedia.find("#{keyword}")
    else
      Wikipedia.find('.')
    end
  end
end
