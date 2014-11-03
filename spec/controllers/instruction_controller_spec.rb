require 'rails_helper'

RSpec.describe InstructionController, :type => :controller do

  describe "GET index" do
    it "returns http success" do
      get :index
      expect(response).to be_success
    end
  end

  describe "GET exit" do
    it "returns http success" do
      get :exit
      expect(response).to be_success
    end
  end

end
