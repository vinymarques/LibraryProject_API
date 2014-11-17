class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :nome
      t.string :autor
      t.text :descricao
      t.integer :quantidade_estoque
      t.integer :quantidade_alugada

      t.timestamps
    end
  end
end
