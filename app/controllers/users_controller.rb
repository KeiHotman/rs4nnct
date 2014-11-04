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
      redirect_to root_path, notice: '登録しました。'
    else
      render 'new'
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
