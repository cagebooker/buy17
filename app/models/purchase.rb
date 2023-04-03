class Purchase < ApplicationRecord
    #relationship
    belongs_to :user
    belongs_to :store
    belongs_to :group
    has_many :orders, dependent: :destroy

    include AASM

    aasm column: :state do
        state :pending, initial: true
        state :finished, :refunded

        event :finish do
            transitions from: :pending, to: :finished
        end
        event :refund do
            transitions from: :pending, to: :refunded
        end
    end

    def total_income
        income = 0  
        self.orders.each do |order|
            income += order.total_price
        end
        income
    end
end
