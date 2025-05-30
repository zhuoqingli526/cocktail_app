class CreateMessages < ActiveRecord::Migration[7.1]
  def change
    create_table :messages do |t|
      t.string :role
      t.text :body
      t.string :session_id

      t.timestamps
    end
  end
end
