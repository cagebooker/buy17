class OrderedItem < ApplicationRecord
    #relationship 
    belongs_to :order 
    belongs_to :item
end
