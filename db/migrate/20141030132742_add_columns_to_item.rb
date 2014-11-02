class AddColumnsToItem < ActiveRecord::Migration
  def change
    remove_column :items, :title
    add_column :items, :year, :integer
    add_column :items, :name, :string
    add_column :items, :english_name, :string
    add_column :items, :grade, :integer
    add_column :items, :department, :integer
    add_column :items, :term, :string
    add_column :items, :credit_num, :integer
    add_column :items, :credit_requirement, :string
  end
end
