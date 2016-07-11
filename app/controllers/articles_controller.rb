class ArticlesController < ApplicationController
	before_action :set_article, only: [:edit, :update, :show, :destroy]

	def index
		@articles = Article.all
	end

	def new
		@article = Article.new
	end 

	def create 
	    @article = Article.new(article_params)
		if @article.save 
			flash[:success] = "Article was created"
			redirect_to article_path(@article)
		else
			render :new #validations failed
		end
	end

	def update 
	    if @article.update(article_params) 
	    	flash[:success] = "Acticle was successfully updated"
			redirect_to article_path(@article)
		else 
			render'edit'
		end
	end

	def destroy 
		redirect_to articles_path
		@article.destroy
		flash[:danger] = "Article was deleted"
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