class CreateUsers < ActiveRecord::Migration[7.0]
    def change
      create_table :users do |t|
        t.string :name, null:false, :limit => 32
        t.string :photo, :limit => 2000, null:false
        t.text :bio, null:false
        
        t.timestamps
        t.bigint :posts_counter, null:false, default: 0
      end
    end
  end