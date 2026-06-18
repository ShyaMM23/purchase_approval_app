class User < ApplicationRecord
  enum :role, {
    requester: 0,
    approver: 1,
    admin: 2
  }
  enum :status, {
    active: 0,
    inactive: 1,
    suspended: 2
  }

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :role, presence: true
  validates :status, presence: true
end