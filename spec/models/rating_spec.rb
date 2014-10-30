require 'rails_helper'

RSpec.describe Rating, :type => :model do

  # association
  it { expect(Rating.new.user).to be_nil }
  it { expect(Rating.new.item).to be_nil }

end
