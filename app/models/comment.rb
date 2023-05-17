class Comment < ApplicationRecord
  validates_presence_of :user_id,:store_id, :group_id, :name
end
