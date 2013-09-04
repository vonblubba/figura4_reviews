class CommentController < ApplicationController
  layout "default"
  before_filter :authorize

  def edit
    @comment = Comment.find(params[:id])
  end

  def update
    if Comment.update(params[:id], params[:comment])
      flash[:notice] = 'Commento modificato.'
      redirect_back
    else
      @comment = Comment.find(params[:id])
      @node = @comment.node
      render :action => 'edit'
    end
  end

  def destroy
    Comment.find(params[:id]).destroy
    redirect_back
  end
end

