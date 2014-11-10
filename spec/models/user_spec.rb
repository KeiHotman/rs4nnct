require 'rails_helper'

RSpec.describe User, :type => :model do

  # association
  it { expect(User.new.targeted_similarities).to be_an ActiveRecord::Associations::CollectionProxy }
  it { expect(User.new.ratings).to be_an ActiveRecord::Associations::CollectionProxy }
  it { expect(User.new.rated_items).to be_an ActiveRecord::Associations::CollectionProxy }

  # validation
  it { expect{ FactoryGirl.create(:user, email: nil) }.to raise_error ActiveRecord::RecordInvalid }
  it { expect{ FactoryGirl.create(:user, name: nil) }.to raise_error ActiveRecord::RecordInvalid }
  it { expect{ FactoryGirl.create(:user, department: nil) }.to raise_error ActiveRecord::RecordInvalid }
  it { expect{ FactoryGirl.create(:user, grade: nil) }.to raise_error ActiveRecord::RecordInvalid }

  it "validates email's uniqueness" do
    expect{
      FactoryGirl.create(:user, email: 'hoge@example.com')
      FactoryGirl.create(:user, email: 'hoge@example.com')
    }.to raise_error ActiveRecord::RecordInvalid
  end

end
