Item.delete_all
User.delete_all
Rating.delete_all
Similarity.delete_all

5.times do |i|
  Item.create title: "item#{i}"
end

items = Item.limit(5)
alice = FactoryGirl.create(:user, name: 'Alice')

[5,3,4,4].each_with_index do |val, index|
  FactoryGirl.create(:rating, value: val, item: items[index], user: alice, prediction: false)
end

u1 = FactoryGirl.create(:user)
[3,1,2,3,3].each_with_index do |val, index|
  FactoryGirl.create(:rating, value: val, item: items[index], user: u1, prediction: false)
end

u2 = FactoryGirl.create(:user)
[4, 3, 4, 3, 5].each_with_index do |val, index|
  FactoryGirl.create(:rating, value: val, item: items[index], user: u2, prediction: false)
end

u3 = FactoryGirl.create(:user)
[3, 3, 1, 5, 4].each_with_index do |val, index|
  FactoryGirl.create(:rating, value: val, item: items[index], user: u3, prediction: false)
end

u4 = FactoryGirl.create(:user)
[1, 5, 5, 2, 1].each_with_index do |val, index|
  FactoryGirl.create(:rating, value: val, item: items[index], user: u4, prediction: false)
end
