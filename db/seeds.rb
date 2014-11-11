Item.delete_all
Feature.delete_all
User.delete_all
Rating.delete_all
Similarity.delete_all

10.times do
  FactoryGirl.create(:user)
end

