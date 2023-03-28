class Purchase < ApplicationRecord
    #relationship
    belongs_to :user
    belongs_to :store
    has_many :orders, dependent: :destroy
end
