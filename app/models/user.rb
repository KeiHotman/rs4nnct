class User < ActiveRecord::Base
  has_many :targeted_similarities, class_name: 'Similarity', foreign_key: 'target_id'
  has_many :ratings, -> { where(taken: true) }
  has_many :rated_items, through: :ratings, class_name: 'Item', source: 'item'

  has_secure_password

  enum department: Constants::DEPARTMENTS

  validates :email, :name, :department, :grade, presence: true
  validates :email, uniqueness: true

  def rated_items_and(items)
    self.rated_items.joins(:ratings).merge(Rating.where(item: items, taken: true)).uniq
  end

  def unrated_items(from = :all)
    if from == :own
      items = Item.refine(grade: self.grade, department: self.department)
    else
      items = Item.all
    end

    items - rated_items
  end
end
