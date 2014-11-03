require 'rails_helper'

RSpec.describe UsersController, :type => :controller do
  describe "#new" do
    it "assigns a new user as @user" do
      get :new
      expect(assigns(:user)).to be_a_new User
    end

    it "redirect to root_path when signed in" do
      user = FactoryGirl.create(:user)
      get :new, {}, {user_id: user.id}
      expect(response).to redirect_to(root_path)
    end
  end

  describe "#create" do
    context "when valid parameters" do
      it "assigns a user given valid parameters as @user" do
        get :create, {user: FactoryGirl.attributes_for(:user)}
        expect(assigns(:user)).to be_persisted
      end
    end

    context "when invalid parameters" do
      it "renders new's view" do
        get :create, {user: {password: nil}}
        expect(response).to render_template(:new)
      end
    end

    it "redirect to root_path when signed in" do
      user = FactoryGirl.create(:user)
      get :create, {}, {user_id: user.id}
      expect(response).to redirect_to(root_path)
    end
  end

  describe "#edit" do
  end

  describe "#update" do
  end

  describe "#destroy" do
  end
end
