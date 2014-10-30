require 'rails_helper'

RSpec.describe Item, :type => :model do

  # association
  it { expect(Item.new.ratings).to be_an ActiveRecord::Associations::CollectionProxy }

end
