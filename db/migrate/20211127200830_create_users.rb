class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :username
      t.string :password_digest
      t.string :email
      t.integer :comments_count
      t.integer :likes_count
      t.boolean :private

      t.timestamps
    end
  end
end
