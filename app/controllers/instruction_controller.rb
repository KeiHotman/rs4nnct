class InstructionController < ApplicationController
  def index
    if current_user
      @next_item = current_user.unrated_items(:own).sample
    else
      @user = User.new
    end
  end

  def exit
  end
end
