FactoryGirl.define do
  factory :user do
    sequence :name do |n|
      "u#{n}"
    end
    sequence :email do |n|
      "u#{n}@exampl.com"
    end
    password "password"
  end

end
