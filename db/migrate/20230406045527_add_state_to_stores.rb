class AddStateToStores < ActiveRecord::Migration[6.1]
  def change
    add_column :stores, :state, :string
  end
end
