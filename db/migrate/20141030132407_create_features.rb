class CreateFeatures < ActiveRecord::Migration
  def change
    create_table :features do |t|
      t.references :item, index: true
      t.string :name
      t.text :content

      t.timestamps
    end
  end
end
