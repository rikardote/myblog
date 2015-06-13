class CommentsController < ApplicationController
  before_action :set_comment, only: [:update, :destroy]
  before_action :set_article
  before_action :authenticate_user!

  respond_to :html
  def create
    @comment = current_user.comments.new(comment_params)
    @comment.article = @article
    respond_to do |format|
      if @comment.save
        format.html { redirect_to @comment.article, notice: 'El comentario fue creado'}
        format.json { render :show, status: :created, location: @comment.article }
      else
        format.html { render :new}
        format.json { render json: @comment.errors, status: :unprocessable_entity}
      end
    end
  end

  def update
    @comment.update(comment_params)
    respond_to do |format|
      if @comment.update
        format.html { redirect_to @comment.article, notice: 'El comentario fue actualizado'}
        format.json { render :show, status: :ok, location: @comment.article }
      else
        format.html { render :new}
        format.json { render json: @comment.errors, status: :unprocessable_entity}
      end
    end
  end

  def destroy
    @comment.destroy
    respond_to do |format|
      if @comment.destroy
        format.html { redirect_to @comment.article, notice: 'El comentario fue borrado'}
        format.json { head :no_content }
      end
    end
  end

  private
    def set_article
      @article = Article.find(params[:article_id])
      
    end
    def set_comment
      @comment = Comment.find(params[:id])
    end

    def comment_params
      params.require(:comment).permit(:user_id, :article_id, :body)
    end
end
