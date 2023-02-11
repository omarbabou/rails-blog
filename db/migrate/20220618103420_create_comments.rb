class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.references :author, foreign_key: {to_table: 'users'}     
      t.text :text, null:false
      t.belongs_to :post, null: false, foreign_key: true

      t.timestamps
    end
  end
end
