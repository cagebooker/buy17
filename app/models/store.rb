class Store < ApplicationRecord
    validates_presence_of :name, :address, :phone, :description
end
