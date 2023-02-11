class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.string :title, null:false, :limit => 32
      t.text :text, null:false

      t.timestamps
      t.bigint :comments_counter, null:false, default: 0
      t.bigint :likes_counter, null:false, default: 0
    end
  end
end
