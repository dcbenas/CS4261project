class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.boolean :verified
      t.string :verificationCode
      t.string :venmoId

      t.timestamps null: false
    end
  end
end
