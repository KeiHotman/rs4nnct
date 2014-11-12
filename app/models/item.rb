class Item < ActiveRecord::Base
  has_many :features
  has_many :ratings
  has_many :opinions

  accepts_nested_attributes_for :features
  accepts_nested_attributes_for :opinions

  enum department: Constants::DEPARTMENTS

  scope :refine, lambda {|arg|
    if arg[:grade] && arg[:department]
      where(grade: arg[:grade], department: Constants::DEPARTMENTS[arg[:department].to_sym])
    elsif arg[:grade]
      where(grade: arg[:grade])
    elsif arg[:department]
      where(department: Constants::DEPARTMENTS[arg[:department].to_sym])
    else
      all
    end
  }
end
