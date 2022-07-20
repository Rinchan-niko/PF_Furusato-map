class Public::TagsController < ApplicationController

  def index
    @tags = Tag.page(params[:page]).per(10)
  end

  def show
    @tag = Tag.find(params[:id])
  end

end
