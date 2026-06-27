class PurchaseRequest < ApplicationRecord
  belongs_to :user
  enum :status, { draft: 0, submitted: 1, approved: 2, rejected: 3 }  
  validates :title, presence: true
  validates :amount,presence: true,numericality:{ greater_than: 0 }
  before_validation :set_default_status
  after_create :log_creation
  after_save :log_save
  after_save :notify_on_status_change
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

  def notify_on_status_change
    if saved_change_to_status?
      old_status = saved_change_to_status[0]
      new_status = saved_change_to_status[1]
      Rails.logger.info "PurchaseRequest ##{id} status changed from #{old_status} to #{new_status}"
    end
  end

  def log_commit
    Rails.logger.info "PurchaseRequest ##{id} committed to DB"
  end

end
