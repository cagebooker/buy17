class Group < ApplicationRecord
  #relationships
  has_many :group_users, :dependent => :destroy
  has_many :users, through: :group_users, :dependent => :nullify

  has_many :group_store, :dependent => :nullify
  has_many :stores, through: :group_store, :dependent => :destroy

  has_many :purchases

  # active_storage
  has_one_attached :cover

  # friendly_id
  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged
  def normalize_friendly_id(input)
    input.to_s.to_slug.normalize(transliterations: :russian).to_s
  end
  def slug_candidates
      [
          :name,
          [:name, SecureRandom.hex[0,8]]
      ]
  end
end
