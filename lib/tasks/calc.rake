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
end
