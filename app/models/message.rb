class Message < ApplicationRecord
  # relationship
  belongs_to :user

  #state machine
  include AASM
  aasm column: :state do
    state :unread, initial: true
    state :read, :unread

    event :read_message do
      transitions from: :unread, to: :read
    end
  end

  #scope
  scope :unread_messages, -> { where(state:"unread")}
  scope :read_messages, -> { where(state:"read")}
end
