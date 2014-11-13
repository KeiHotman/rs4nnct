class UsersController < ApplicationController
  before_action :unauthenticate_user!, only: %i(new create)
  before_action :authenticate_user!, only: %i(edit update)

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      if @next_item = @user.unrated_items.sample
        redirect_to item_path(@next_item), notice: '被験者情報が登録されました。これより各科目について評価を入力してください。'
      else
        redirect_to instruction_exit_path, notice: '実験対象の科目がありませんでした。'
      end
    else
      render 'instruction/index'
    end
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user

    if @user.update(user_params)
      redirect_to root_path, notice: "変更しました。"
    else
      render 'edit'
    end
  end

  private
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :name, :grade, :department)
  end
end
