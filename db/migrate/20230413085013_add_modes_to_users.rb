class AddModesToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :mode, :string
  end
end
