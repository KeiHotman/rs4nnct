class ItemsController < ApplicationController
  before_action :authenticate_user!

  def index
    @rated_items = current_user.rated_items
  end

  def show
    @item = Item.find(params[:id])
  end
end
