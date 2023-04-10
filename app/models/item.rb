class Item < ApplicationRecord
    # relationship
    belongs_to :store

    # active storage
    has_one_attached :logo
end
