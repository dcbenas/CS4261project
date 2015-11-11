class CreateUserOrders < ActiveRecord::Migration
  def change
    create_table :user_orders do |t|
      t.string :Username
      t.integer :OrderID
      t.text :Listofitems
      t.float :Total

      t.timestamps null: false
    end
  end
end
