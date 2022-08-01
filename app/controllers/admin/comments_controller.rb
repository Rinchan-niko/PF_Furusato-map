class Admin::CommentsController < ApplicationController
  def index
    @comments = Comment.page(params[:page]).per(10)
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to admin_comments_path
  end
end
