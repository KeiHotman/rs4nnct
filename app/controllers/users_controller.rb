class UsersController < ApplicationController
  before_action :unauthenticate_user!, only: %i(new create)

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
  end

  def update
  end

  def destroy
  end

  private
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :name, :grade, :department)
  end
end
