class AddStateToPurchases < ActiveRecord::Migration[6.1]
  def change
    add_column :purchases, :state, :string
  end
end
