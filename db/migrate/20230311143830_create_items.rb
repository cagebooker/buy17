class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.string :name
      t.integer :price

      t.string :image

      t.belongs_to :store, index: true
      t.timestamps
    end
  end
end
