class Opinion < ActiveRecord::Base
  belongs_to :user
  belongs_to :item
  belongs_to :subject
end
