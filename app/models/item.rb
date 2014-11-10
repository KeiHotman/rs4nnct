class Item < ActiveRecord::Base
  has_many :features
  has_many :ratings

  accepts_nested_attributes_for :features

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
