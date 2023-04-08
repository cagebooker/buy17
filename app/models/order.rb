class Order < ApplicationRecord
    #relationship
    belongs_to :user
    belongs_to :purchase
    has_many :ordered_items
    has_many :items, through: :ordered_items

    accepts_nested_attributes_for :ordered_items, allow_destroy: true
    
    def total_price
        t_price = 0
        self.ordered_items.each do |order_item|
            if order_item.item === nil
            else
                t_price += (order_item.quantity * order_item.item.price)
            end
        end
        t_price
    end
end
