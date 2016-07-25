class UsersController < ApplicationController
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
            flash[:success] = "Welcome to the alpha blog #{@user.username}"
            redirect_to articles_path
        else
            render :new # validations failed
        end
    end

    def edit
        @user = User.find(params[:id])
    end

    def update
        @user = User.find(params[:id])
        if @user.update(user_params)
            flash[:success] = "#{@user.username} has been successfully updated!"
            redirect_to articles_path
        else
            render :edit # validations failed
        end
    end

    def show
        @user = User.find(params[:id])
        @articles = Article.paginate(page: params[:page], per_page: 5)
    end

    def user_params
        params.require(:user).permit(:username, :email, :password)
    end
end
