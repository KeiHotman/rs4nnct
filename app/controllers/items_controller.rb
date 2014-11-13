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
    @unrated_items_num = current_user.unrated_items.size
    @subjects = Subject.all
    @subjects.each do |s|
      @item.opinions.build(subject: s)
    end
  end

  def create
    @item = Item.new(item_params)

    @result = @item.save
    render "create", formats: [:json], handlers: [:jbuilder]
  end

  def rating
    @item = Item.find(params[:id])
    @rating = Rating.find_or_initialize_by(item: @item, user: current_user)
    if params[:value].present?
      @rating.value = params[:value]
      @rating.taken = true
    else
      @rating.taken = false
    end
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

  def opinion
    @item = Item.find(params[:id])
    @item.update(opinion_params)
    @next_item = current_user.unrated_items.sample
    if @next_item
      redirect_to item_path(@next_item)
    else
      redirect_to items_path
    end
  end

  private
    def set_items
      @grade = params[:grade].presence
      @department = params[:department].presence
      @items = current_user.rated_items
    end

    def item_params
      params.require(:item).permit(:year, :grade, :department, :name, :english_name, :term, :credit_num, :credit_requirement, :provided_by, features_attributes: [:name, :content])
    end

    def opinion_params
      params.require(:item).permit(opinions_attributes: [:subject_id, :value, :user_id])
    end
end
