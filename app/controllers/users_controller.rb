class UsersController < ApplicationController

  before_action :signed_in_user, only:[:edit, :update]
  before_action :correct_user, only:[:edit, :update]

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

  def edit
  	@page_title = "Edit user"
  end

  def update
    @page_title = "Update user"
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated!"
      redirect_to @user
    else 
      render "edit"
    end
  end
	
	private
		def user_params
			params.require(:user).permit(:name, :password, :password_confirmation, :email)
		end	

    def signed_in_user
      unless signed_in?
        store_location  # store the location that the user doesnt have the access to
        redirect_to signin_path, notice: "Please sign in first!"        
      end
    end

    def correct_user
        @user = User.find(params[:id])
        redirect_to root_path unless current_user?(@user)
    end
    
end