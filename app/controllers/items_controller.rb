class ItemsController < ApplicationController
  protect_from_forgery except: %i(create)
  before_action :authenticate_user!, except: %i(create)
  before_action :set_items, only: %i(index)

  def index
    @rated_items = current_user.rated_items
  end

  def show
    @item = Item.find(params[:id])
    @rating = Rating.find_by(item: @item, user: current_user)
    @next_item = current_user.unrated_items.sample
    @unrated_items_num = current_user.unrated_items(:own).size
  end

  def create
    @item = Item.new(item_params)

    @result = @item.save
    render "create", formats: [:json], handlers: [:jbuilder]
  end

  def rating
    @item = Item.find(params[:id])
    @rating = Rating.find_or_initialize_by(item: @item, user: current_user)
    @rating.value = params[:value]
    if @rating.save
      respond_to do |format|
        format.html do
          if @next_item = current_user.unrated_items.sample
            redirect_to item_path(@next_item)
          else
            redirect_to items_path, notice: "全てのアイテムを評価しました。"
          end
        end
        format.js
      end
    else
      redirect_to item_path(@item), alert: "不正な値です。"
    end
  end

  private
    def set_items
      @grade = params[:grade].presence
      @department = params[:department].presence
      @items = current_user.rated_items
    end

    def item_params
      params.require(:item).permit(:name, :english_name, :term, :credit_num, :credit_requirement, :features_attributes)
    end
end
