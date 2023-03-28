class Group < ApplicationRecord
  #relationships
  has_many :group_users, :dependent => :destroy
  has_many :users, through: :group_users, :dependent => :nullify

  has_many :group_store, :dependent => :nullify
  has_many :stores, through: :group_store, :dependent => :nullify
end
