class User < ActiveRecord::Base
  has_many :ratings
  has_many :rated_items, through: :ratings, class_name: 'Item', source: 'item'

  def rated_items_and(items)
    self.rated_items.joins(:ratings).merge(Rating.where(item: items)).uniq
  end
end
