class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # relationship
  has_many :purchases
  has_many :group_users
  has_many :groups, through: :group_users
  has_many :stores 
  has_many :orders

  has_many :messages

  include AASM
    aasm column: :mode do
      state :light, initial: true
      state :dark
    
      event :to_dark do
        transitions from: :light, to: :dark
      end
      event :to_light do
        transitions from: :dark, to: :light
      end
      
    end

  def name
    email.split('@')[0]
  end
end
