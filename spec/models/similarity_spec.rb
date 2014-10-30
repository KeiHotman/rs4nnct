require 'rails_helper'

RSpec.describe Similarity, :type => :model do

  # association
  it { expect(Similarity.new.subject).to be_nil }
  it { expect(Similarity.new.target).to be_nil }

end
