class AddAuthorToQuestion < ActiveRecord::Migration[7.0]
  def change
    change_table :questions do |t|
      t.belongs_to :author, foreign_key: { to_table: :users }, index: true
    end
  end
end