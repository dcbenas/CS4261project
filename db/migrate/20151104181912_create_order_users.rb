class CreateOrderUsers < ActiveRecord::Migration
  def change
    create_table :order_users do |t|
      t.string :username
      t.integer :orderID
      t.text :listOfItems

      t.timestamps null: false
    end
  end
end
