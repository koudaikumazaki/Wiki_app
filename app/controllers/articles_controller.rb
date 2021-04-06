class ArticlesController < ApplicationController
  def index
    
  end

  def search
    require 'wikipedia'
    if params[:keyword]
      @page = Wikipedia.find(params[:keyword])
      @text = WikiCloth::Parser.new(data: @page.text).to_html
      @sanitize_text = Sanitize.clean(@text)
    else
      @page = Wikipedia.find('.')  
    end
  end
  
end
