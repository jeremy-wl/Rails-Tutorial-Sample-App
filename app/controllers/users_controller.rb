class UsersController < ApplicationController
  def new
    @page_title = "Sign Up"
    @user = User.new
  end

  def show
  	@user = User.find(params[:id])
  	@page_title = User.find(params[:id]).name
  end

  def create
  	@page_title = "CREATE"
	@user = User.new(user_params)
	if @user.save
		sign_in @user
		flash[:success] = "Welcome to Ruby on Rails Tutorial!"
		redirect_to @user
	else
		render 'new'
	end
  end

	private
		def user_params
			params.require(:user).permit(:name, :password, :password_confirmation, :email)
		end	
  
end