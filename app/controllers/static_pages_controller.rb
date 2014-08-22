class StaticPagesController < ApplicationController
  def home
  	@page_title = "Home Page"
  end

  def about
  	 @page_title = "About Us"
  end

  def contact
  	@page_title = "Contact Us"
  end

  def help
  	@page_title = "Help"
  end
  
end