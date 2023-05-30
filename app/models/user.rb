class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # devise :database_authenticatable, :registerable,
  #        :recoverable, :rememberable, :validatable
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable, 
          :omniauthable, omniauth_providers: [:google_oauth2]

  # relationship
  has_many :purchases
  has_many :group_users
  has_many :groups, through: :group_users
  has_many :stores 
  has_many :orders
  has_many :postits

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

  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.where(email: data['email']).first
    # 下面處理是當資料庫內部沒有對應的帳號密碼時，建立給我們專案資料庫去對應每次授權的 token。
    unless user
      user = User.create(name: data['name'],
         email: data['email'],
         password: Devise.friendly_token[0,20]
      )
    end
    user
  end
end
