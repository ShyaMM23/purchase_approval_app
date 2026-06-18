class User < ApplicationRecord
  enum :role, {
    requester: 0,
    approver: 1,
    admin: 2
  }

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :role, presence: true
end