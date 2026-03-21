class User < ApplicationRecord
  has_secure_password

  enum :role, { user: 0, admin: 1 }

  has_many :tickets, foreign_key: :requester_id, dependent: :destroy

  validates :email, presence: true,
                    uniqueness: { case_sensitive: false },
                    format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, length: { minimum: 6 }, if: -> { new_record? || password.present? }

  before_save { self.email = email.downcase }
end
