class AddAdministratorPermittedToUsers < ActiveRecord::Migration
  def change
    add_column :users, :administrator_permitted, :boolean
  end
end
