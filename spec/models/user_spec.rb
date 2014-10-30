require 'rails_helper'

RSpec.describe User, :type => :model do

  # association
  it { expect(User.new.ratings).to be_an ActiveRecord::Associations::CollectionProxy }
  it { expect(User.new.rated_items).to be_an ActiveRecord::Associations::CollectionProxy }
end
