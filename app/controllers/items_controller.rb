class ItemsController < ApplicationController
  before_action :authenticate_user!

  def index
    @rated_items = current_user.rated_items
  end

  def show
    @item = Item.find(params[:id])
    @rating = Rating.find_by(item: @item, user: current_user)
  end

  def rating
    @item = Item.find(params[:id])
    @rating = Rating.find_or_initialize_by(item: @item, user: current_user)
    @rating.value = params[:value]
    if @rating.save
      redirect_to item_path(@item), notice: "評価しました。"
    else
      redirect_to item_path(@item), alert: "不正な値です。"
    end
  end
end
