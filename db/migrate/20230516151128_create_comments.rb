class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.text :content
      t.references :store
      t.references :user
      t.references :group

      t.timestamps
    end
  end
end
