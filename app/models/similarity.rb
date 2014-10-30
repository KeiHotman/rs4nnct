class Similarity < ActiveRecord::Base
  belongs_to :subject, class_name: 'User'
  belongs_to :target, class_name: 'User'
end
