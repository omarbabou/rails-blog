class CreateComments < ActiveRecord::Migration[7.0]
    def change
      create_table :comments do |t|
        t.references :author, foreign_key: {to_table: 'users'}     
        t.text :text
        t.belongs_to :posts, null: false, foreign_key: true
  
        t.timestamps
      end
    end
  end