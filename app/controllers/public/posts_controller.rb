class Public::PostsController < ApplicationController

  before_action :authenticate_user!
  before_action :correct_post,only: [:edit]

  def correct_post
    @post = Post.find(params[:id])
    unless @post.user.id == current_user.id
      redirect_to posts_path
    end
  end

  def new
    @post = Post.new
    @tags = Tag.all
    @prefectures = Prefecture.all
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to post_path(@post.id), notice: "You have created book successfully."
    else
      @post = Post.new
      @tags = Tag.all
      @prefectures = Prefecture.all
      render 'new'
    end
  end

  def index
    @posts = Post.page(params[:page]).per(10)
  end

  def show
    @post = Post.find(params[:id])
    @user = @post.user
    @comment = Comment.new
  end

  def edit
    @post = Post.find(params[:id])
    @tags = Tag.all
    @prefectures = Prefecture.all
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_path(@post), notice: "You have updated book successfully."
    else
      @tags = Tag.all
      @prefectures = Prefecture.all
      render "edit"
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end

  def search
    @section_title = "「#{params[:search]}」の検索結果"
    if params[:search].present?
      @posts = Post.where(['title LIKE ?', "%#{params[:search]}%"])
    else
      @posts = Post.none
    end
  end

  private

  def post_params
    params.require(:post).permit(:image, :title, :content, :tag_id, :prefecture_id)
  end
end
