class CreateLikes < ActiveRecord::Migration[7.0]
  def change
    create_table :likes do |t|
      t.references :author, foreign_key: {to_table: 'users'}

      t.belongs_to :post, null: false, foreign_key: true

      t.timestamps
    end
  end
end