class CreateRents < ActiveRecord::Migration
  def change
    create_table :rents do |t|
    	t.references :user
    	t.references :book
    	t.boolean :status

      t.timestamps
    end
  end
end
