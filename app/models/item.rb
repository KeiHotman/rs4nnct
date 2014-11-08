class Item < ActiveRecord::Base
  has_many :features
  has_many :ratings

  accepts_nested_attributes_for :features

  enum department: Constants::DEPARTMENTS
end
