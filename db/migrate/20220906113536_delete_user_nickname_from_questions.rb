class DeleteUserNicknameFromQuestions < ActiveRecord::Migration[7.0]
  def change
    reversible do |dir|
      change_table :questions do |t|
        dir.up { t.remove :user_nickname, null: false, index: true }
      end
    end
  end
end
