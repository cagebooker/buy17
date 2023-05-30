class CreatePostits < ActiveRecord::Migration[6.1]
  def change
    create_table :postits do |t|
      t.string :content
      t.string :color
      t.integer :pos_x
      t.integer :pos_y
      t.references :user

      t.timestamps
    end
  end
end
