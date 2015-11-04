class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :primaryUser
      t.text :location
      t.boolean :isPlaced
      t.decimal :reqd_total
      t.integer :merchantID

      t.timestamps null: false
    end
  end
end
