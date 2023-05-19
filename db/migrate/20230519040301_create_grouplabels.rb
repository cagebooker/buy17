class CreateGrouplabels < ActiveRecord::Migration[6.1]
  def change
    create_table :grouplabels do |t|
      t.references :users
      t.references :groups
      t.string :name
      t.timestamps
    end
  end
end
