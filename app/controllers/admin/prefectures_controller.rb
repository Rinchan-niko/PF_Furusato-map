class Admin::PrefecturesController < ApplicationController

  before_action :authenticate_admin!

  def index
    @prefecture = Prefecture.new
    @prefectures = Prefecture.page(params[:page]).per(10)
  end

  def create
    @prefecture = Prefecture.new(prefecture_params)
    if @prefecture.save
      redirect_to request.referer
    else
      @prefectures = Prefecture.all
      render :index
    end
  end

  def edit
    @prefecture = Prefecture.find(params[:id])
  end

  def update
    @prefecture = Prefecture.find(params[:id])
    if @prefecture.update(prefecture_params)
      redirect_to admin_prefectures_path
    else
      render :edit
    end
  end

  private
    def prefecture_params
      params.require(:prefecture).permit(:name)
    end
end