class ArticlesController < ApplicationController
  http_basic_authenticate_with name: Settings.authentication.name, 
                               password: Settings.authentication.password, 
                               except: [:index, :show]

  def index
    @articles = Article.all
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    render('new') and return unless @article.save
    redirect_to(@article)
  end

  def show
    @article = Article.find(params[:id])
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    render 'edit' and return unless @article.update(article_params())
    redirect_to @article
  end

  def destroy
    article = Article.find(params[:id])
    article.destroy
    redirect_to article
  end

  private

  def article_params
    params.require(:article).permit(:title, :body)
  end
end
