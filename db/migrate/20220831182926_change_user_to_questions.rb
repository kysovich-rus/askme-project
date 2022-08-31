class ChangeUserToQuestions < ActiveRecord::Migration[7.0]
  def change
    reversible do |dir|
      change_table :questions do |t|
        dir.down { t.integer :user_id, index: true }
        dir.up { t.string :user_nickname, null: false, index: true }
      end
    end
  end
end
