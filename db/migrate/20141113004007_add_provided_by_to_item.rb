class AddProvidedByToItem < ActiveRecord::Migration
  def change
    add_column :items, :provided_by, :string
  end
end
