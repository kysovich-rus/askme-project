class MakeNicknameAndEmailUniqueToUsers < ActiveRecord::Migration[7.0]
  def change
    remove_index :users, :nickname
    add_index :users, :nickname, unique: true
    remove_index :users, :email
    add_index :users, :email, unique: true
  end
end
