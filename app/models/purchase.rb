class Purchase < ApplicationRecord
    before_create :generate_order_num

    #relationship
    belongs_to :user
    belongs_to :store
    belongs_to :group
    has_many :orders, dependent: :destroy

    include AASM

    aasm column: :state do
        state :pending, initial: true
        state :finished, :refunded, :paid

        event :pay do
            transitions from: :pending, to: :paid
        end
        event :finish do
            transitions from: :paid, to: :finished
        end
        event :refund do
            transitions from: [:pending,:paid], to: :refunded
        end
    end

    def total_income
        income = 0  
        self.orders.each do |order|
            income += order.total_price
        end
        income
    end
    def count_orders
        count = 0
        self.orders.each do |order|
            if order.total_price == 0 
            else 
                count += 1
            end 
        end
        count
    end
    scope :finished_purchase, -> { where(state:"finished")}
    scope :refunded_purchase, -> { where(state:"refunded")}
    scope :pending_purchase, -> { where("end_time > ?", Time.now)}
    
    private
    def generate_order_num
        self.num = SecureRandom.hex(5)
    end
end
