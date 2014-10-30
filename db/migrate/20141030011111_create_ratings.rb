class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.references :user, index: true
      t.references :item, index: true
      t.float :score

      t.timestamps
    end
  end
end
