class AddNumToPurchases < ActiveRecord::Migration[6.1]
  def change
    add_column :purchases, :num, :string
  end
end
