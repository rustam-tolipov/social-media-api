class Posts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.text :content
      t.string :image
      t.references :user, foreign_key: true
      
      t.timestamps
    end
  end
end
