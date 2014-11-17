class AddPasswordHashToUser < ActiveRecord::Migration
  def change
    add_column :users, :secret_p, :string
  end
end
