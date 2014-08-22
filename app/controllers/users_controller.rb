class UsersController < ApplicationController
  def new
    @page_title = "Sign Up"
  end

  def show
  	@user = User.find(params[:id])
  	@page_title = User.find(params[:id]).name
  end

end