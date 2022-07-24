class Public::PrefecturesController < ApplicationController

  def index
    @prefectures = Prefecture.page(params[:page]).per(10)
  end

  def show
    @prefecture = Prefecture.find(params[:id])
  end

end
