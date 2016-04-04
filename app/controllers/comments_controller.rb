class CommentsController < ApplicationController
  http_basic_authenticate_with name: Settings.authentication.name, 
                               password: Settings.authentication.password, 
                               only: [:destroy]

  def create
    @article = Article.find(params[:article_id])
    # comment = Comment.new(text: params[:comment][:text], article_id: params[:article_id])
    # comment.save
    @comment = @article.comments.create(comment_params())
    redirect_to @article
  end

  def destroy
    @article  = Article.find(params[:article_id])
    # @comment = Comment.find(params[:id])
    @comment = @article.comments.find(params[:id])
    @comment.destroy

    redirect_to @article
  end

  private

  def comment_params
    params.require(:comment).permit(:commenter, :body)
  end
end
