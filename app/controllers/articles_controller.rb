class ArticlesController < ApplicationController
    before_action :set_article, only: [:edit, :update, :show, :destroy]

    def index
        @articles = Article.paginate(page: params[:page], per_page: 5)
        @count = Article.count
    end

    def new
        @article = Article.new
    end

    def create
        @article = Article.new(article_params)
        @article.user = current_user
        if @article.save
            flash[:success] = 'Article was created'
            redirect_to article_path(@article)
        else
            render :new # validations failed
        end
    end

    def edit
        if @article.user != current_user
            redirect_to root_path
            flash[:danger] = 'You do not have permision to edit that article'
        end
    end

    def update
        if @article.update(article_params)
            flash[:success] = 'Acticle was successfully updated'
            redirect_to article_path(@article)
        else
            render'edit'
      end
    end

    def destroy
        redirect_to articles_path
        @article.destroy
        flash[:danger] = 'Article was deleted'
    end

    def show
    end

    private

    def set_article
        @article = Article.find(params[:id])
      end

    def article_params
        params.require(:article).permit(:title, :description)
      end
end
