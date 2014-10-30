require 'rails_helper'

RSpec.describe Feature, :type => :model do

  # association
  it { expect(Feature.new.item).to be_nil }

end
