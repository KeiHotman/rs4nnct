class CreateOpinions < ActiveRecord::Migration
  def change
    create_table :opinions do |t|
      t.references :user, index: true
      t.references :item, index: true
      t.references :subject, index: true
      t.integer :value

      t.timestamps
    end
  end
end
