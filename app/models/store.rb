class Store < ApplicationRecord
    validates_presence_of :name, :address, :phone, :description

    # active_storage
    has_one_attached :cover

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
      event :prepare do
        transitions from: [:online], to: :pending
      end

    end

    def total_income
      t_income = 0 
      self.purchases.finished_purchase.each do |purchase|
        t_income += purchase.total_income
      end
      t_income
    end

    #scope
    scope :online_store, -> { where(state:"online")}
    scope :available_store, -> { where.not(state:"offline")}
end
