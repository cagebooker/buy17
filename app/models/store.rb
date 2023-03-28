class Store < ApplicationRecord
    validates_presence_of :name, :address, :phone, :description

    #relationships
    has_many :items
    has_many :purchases

    has_many :group_store, :dependent => :nullify
    has_many :groups, through: :group_store

    belongs_to :user
end
