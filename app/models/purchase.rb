class Purchase < ApplicationRecord
    #relationship
    belongs_to :user
    belongs_to :store
    belongs_to :group
    has_many :orders, dependent: :destroy

    def total_income
        income = 0  
        self.orders.each do |order|
            income += order.total_price
        end
        income
    end
end
