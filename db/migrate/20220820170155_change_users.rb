class ChangeUsers < ActiveRecord::Migration[7.0]
  def change
    change_column :users, :header_color, :string, default: '#370617'
    change_column :users, :nickname, :string, unique: true
    change_column :users, :email, :string, unique: true
    add_index :users, :nickname
    add_index :users, :email
  end
end
