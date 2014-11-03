class AddEmailEtcToUser < ActiveRecord::Migration
  def change
    add_column :users, :email, :string
    add_column :users, :password_digest, :string
    add_column :users, :grade, :integer
    add_column :users, :department, :integer
  end
end
