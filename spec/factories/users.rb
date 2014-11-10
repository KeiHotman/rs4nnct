FactoryGirl.define do
  factory :user do
    sequence :name do |n|
      "u#{n}"
    end
    sequence :email do |n|
      "u#{n}@exampl.com"
    end
    grade { rand(1..5) }
    department { Constants::DEPARTMENTS.keys[1..8].sample }
    password "password"
  end

end
