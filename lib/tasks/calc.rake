# encoding: utf-8

namespace :calc do
  desc "Calculation all users' similarities"
  task similarities: :environment do
    start_at = Time.now
    subject_users = User.all
    target_users = User.all

    subject_users.each do |subject_user|
      target_users.each do |target_user|
        next if subject_user == target_user

        # ユーザ類似度モデルを検索or登録
        similarity = Similarity.find_or_create_by!(subject: subject_user, target: target_user)

        # 両ユーザが評価したアイテム
        both_rated_items = subject_user.rated_items_and(target_user.rated_items)
        subject_rating_average = subject_user.ratings.where(item: both_rated_items).average(:value)
        target_rating_average = target_user.ratings.where(item: both_rated_items).average(:value)

        both_deviation_products_sum = 0
        subject_deviation_square_sum = 0
        target_deviation_square_sum = 0

        both_rated_items.each do |item|
          subject_user_rating = subject_user.ratings.find_by(item: item)
          target_user_rating = target_user.ratings.find_by(item: item)

          subject_rating_deviation = subject_user_rating.value - subject_rating_average
          target_rating_deviation = target_user_rating.value - target_rating_average

          both_deviation_products_sum += subject_rating_deviation * target_rating_deviation
          subject_deviation_square_sum += subject_rating_deviation ** 2
          target_deviation_square_sum += target_rating_deviation ** 2
        end

        similarity.value = both_deviation_products_sum /
          (Math.sqrt(subject_deviation_square_sum) * Math.sqrt(target_deviation_square_sum))
        similarity.rated_items_num = both_rated_items.size
        similarity.save
      end
    end
    puts "SUBJECT USER: #{subject_users.size}"
    puts "TARGET USER: #{subject_users.size}"
    puts "TIME: #{Time.now - start_at} sec"
  end

  task predictions: :environment do
    start_at = Time.now
    users = User.all
    items = Item.all
    users.each do |user|
      similar_users = User.joins(:targeted_similarities).merge(Similarity.where(subject: user).where('value > 0.7').limit(2))
      items.each do |item|
        rating = Rating.find_or_initialize_by(user: user, item: item)
        next if !rating.prediction && rating.persisted?

        similarity_deviation_product = 0
        total_similarity = 0
        similar_users.each do |similar_user|
          similarity = Similarity.find_by(subject: user, target: similar_user)
          similars_rating = Rating.find_by(user: similar_user, item: item)
          if similars_rating
            similarity_deviation_product += similarity.value * (similars_rating.value - similar_user.ratings.average(:value))
            total_similarity += similarity.value
          end
        end
        begin
          prediction = user.ratings.average(:value) + similarity_deviation_product / total_similarity
          rating.assign_attributes(value: prediction, prediction: true)
          rating.save
        rescue
          puts "Error: user: #{user.name}, item: #{item.title}"
        end
      end
    end
    puts "USER: #{users.size}"
    puts "ITEM: #{items.size}"
    puts "TIME: #{Time.now - start_at} sec"
  end
end
