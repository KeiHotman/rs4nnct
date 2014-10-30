class Similarity < ActiveRecord::Base
  belongs_to :subject
  belongs_to :object
end
