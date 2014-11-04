require 'rails_helper'

RSpec.describe ItemsController, :type => :controller do
  describe "#index" do
    it "assigns current_user rated items as @rated_items" do
      user = FactoryGirl.create(:user)
      item = FactoryGirl.create(:item)
      rating = FactoryGirl.create(:rating, user: user, item: item)

      get :index, {}, {user_id: user.id}
      expect(assigns(:rated_items)).to include item
    end

    it "redirect to root_path when signed out" do
      user = FactoryGirl.create(:user)
      get :index, {}, {user_id: nil}
      expect(response).to redirect_to(root_path)
    end
  end

  describe "#show" do
    it "assigns the requested item as @item" do
      item = FactoryGirl.create(:item)
      user = FactoryGirl.create(:user)
      get :show, {id: item.id}, {user_id: user.id}
      expect(assigns(:item)).to eq item
    end
  end

  describe "#rating" do
    it "assigns the requested item as @item" do
      item = FactoryGirl.create(:item)
      user = FactoryGirl.create(:user)
      post :rating, {id: item.id}, {user_id: user.id}
      expect(assigns(:item)).to eq item
    end

    it "creates current_user's new rating" do
      item = FactoryGirl.create(:item)
      user = FactoryGirl.create(:user)
      expect{
        post :rating, {id: item.id, value: 3}, {user_id: user.id}
      }.to change(Rating, :count).from(0).to(1)
    end
  end
end
