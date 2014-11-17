class AddColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :nome, :string
    add_column :users, :endereco, :string
    add_column :users, :cpf, :integer
  end
end
