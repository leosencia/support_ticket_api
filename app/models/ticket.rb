class Ticket < ApplicationRecord
  belongs_to :requester, class_name: 'User'

  enum :category, {
    general: 0,
    technical: 1,
    billing: 2,
    other: 3
  }

  enum :priority, {
    low: 0,
    medium: 1,
    high: 2,
    critical: 3
  }

  enum :status, {
    open: 0,
    in_progress: 1,
    resolved: 3,
    closed: 4
  }

  validates :subject, presence: true, length: {maximum: 150}
  validates :description, presence: true
  validates :category, presence: true
  validates :priority, presence: true
  validates :status, presence: true

  scope :by_status, ->(status) {where(status: status)}
  scope :by_priority, ->(priority) {where(priority: priority)}
  scope :by_category, ->(category) {where(category: category)}
end
