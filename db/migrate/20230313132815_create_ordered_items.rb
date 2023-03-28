class CreateOrderedItems < ActiveRecord::Migration[6.1]
  def change
    create_table :ordered_items do |t|
      t.belongs_to :order,index: true
      t.belongs_to :item,index: true
      t.integer :quantity, default: 1
      t.timestamps
    end
  end
end
