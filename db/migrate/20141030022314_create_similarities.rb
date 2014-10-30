class CreateSimilarities < ActiveRecord::Migration
  def change
    create_table :similarities do |t|
      t.references :subject, index: true
      t.references :object, index: true
      t.float :value

      t.timestamps
    end
  end
end
