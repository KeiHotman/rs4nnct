class AddTakenToRating < ActiveRecord::Migration
  def change
    add_column :ratings, :taken, :boolean
  end
end
