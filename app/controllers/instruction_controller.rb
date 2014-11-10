class InstructionController < ApplicationController
  def index
    if current_user
      @next_item = current_user.unrated_items.sample
    end
  end

  def exit
  end
end
