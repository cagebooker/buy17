class Store < ApplicationRecord
    validates_presence_of :name, :address, :phone, :description

    #relationships
    has_many :items
end
