class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :username
      t.string :bio
      t.string :avatar_image
      t.string :email
      # ❌ Devise does not use this
      # t.string :password

      t.timestamps
    end
  end
end
