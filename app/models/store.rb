class Store < ApplicationRecord
    validates_presence_of :name, :address, :phone, :description

    #relationships
    has_many :items
    has_many :purchases

    has_many :group_store, :dependent => :nullify
    has_many :groups, through: :group_store

    belongs_to :user

    #state machine
    include AASM
    aasm column: :state do
      state :pending, initial: true
      state :online, :offline
    
      event :up do
        transitions from: [:pending,:offline], to: :online
      end
      event :down do
        transitions from: [:online], to: :offline
      end

    end

    def total_income
      t_income = 0 
      self.purchases.finished_purchase.each do |purchase|
        t_income += purchase.total_income
      end
      t_income
    end
    scope :online_store, -> { where(state:"online")}
end
