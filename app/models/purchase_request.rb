class PurchaseRequest < ApplicationRecord
  belongs_to :user
  enum :status, { draft: 0, submitted: 1, approved: 2, rejected: 3 }  
  validates :title, presence: true
  validates :amount,presence: true,numericality:{ greater_than: 0 }
  before_validation :set_default_status
  after_create :log_creation
  after_save :log_save
  after_commit :log_commit, on: [:create, :update]

  private
   def set_default_status
    self.status ||= :draft
  end

  def log_creation
    Rails.logger.info "PurchaseRequest ##{id} created: #{title}"
  end

  def log_save
    Rails.logger.info "PurchaseRequest ##{id} saved (status: #{status})"
  end

  def log_commit
    Rails.logger.info "PurchaseRequest ##{id} committed to DB"
  end
end
