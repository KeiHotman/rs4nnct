class CreateSimilarities < ActiveRecord::Migration
  def change
    create_table :similarities do |t|
      t.references :subject, index: true
      t.references :target, index: true
      t.float :value
      t.integer :rated_items_num

      t.timestamps
    end
  end
end
