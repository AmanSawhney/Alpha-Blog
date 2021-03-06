class UsersController < ApplicationController
    before_action :set_user, only: [:edit, :update, :show]
    def new
        @user = User.new
    end

    def index
        @users = User.paginate(page: params[:page], per_page: 5)
    end

    def create
        @user = User.new(user_params)
        @user.username = @user.username.slice(0, 1).capitalize + @user.username.slice(1..-1)
        if @user.save
            session[:user_id] = @user.id
            flash[:success] = "Welcome to the alpha blog #{@user.username}"
            redirect_to user_path(@user)
        else
            render :new # validations failed
        end
    end

    def edit
        if current_user != @user
            redirect_to root_path
            flash[:danger] = 'You do not have access to edit that page'
        end
    end

    def update
        if @user.update(user_params)
            flash[:success] = "#{@user.username} has been successfully updated!"
            redirect_to articles_path
        else
            render :edit # validations failed
        end
    end

    def show
        @articles = Article.paginate(page: params[:page], per_page: 5)
    end

    def user_params
        params.require(:user).permit(:username, :email, :password)
    end

    def set_user
        @user = User.find(params[:id])
    end
end
