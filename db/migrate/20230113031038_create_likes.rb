class CreateLikes < ActiveRecord::Migration[7.0]
  def change
    create_table :likes do |t|
      t.string :likeable_type
      t.integer :likeable_id
      t.references :user, foreign_key: true
      
      t.timestamps
    end
  end
end
