class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :description
      t.belongs_to :user, foreign_key: true
      t.integer :lock_version

      t.timestamps
    end
  end
end
