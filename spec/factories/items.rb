FactoryGirl.define do
  factory :item do
    sequence :name do |n|
      "Item #{n}"
    end
  end
end
