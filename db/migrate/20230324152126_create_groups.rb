class CreateGroups < ActiveRecord::Migration[6.1]
  def change
    create_table :groups do |t|
      t.string :name
      t.integer :number
      t.string :state

      t.timestamps
    end
  end
end
