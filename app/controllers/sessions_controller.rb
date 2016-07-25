class SessionsController < ApplicationController

	def new

	end

	def create
		user = User.find_by(email: params[:session][:email].downcase)
		if user && user.authenticate(params[:session][:password])
			session[:user_id] = user.id #stored by the browser for requests
			flash[:success] = "You have logged in"
			redirect_to users_path(user)
		else
			flash.now[:danger] = "No user exists with this login information"
			render 'new'
		end
	end

	def destroy
		session[:user_id] = nil
		flash[:success] = "You have logged out"
		redirect_to root_path
	end

end
