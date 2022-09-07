class User < ApplicationRecord
  has_secure_password
  
  before_validation :nickname_downcase

  NICKNAME_REGEXP = /\A[a-z0-9\_]+\z/
  EMAIL_REGEXP = /\A[a-z0-9]+@[a-z0-9]+\.[a-z]+\z/

  validates :email, presence: true, uniqueness: true, format: {with:EMAIL_REGEXP}
  validates :nickname, presence: true, length: {maximum: 40},
    uniqueness: true, format: {with: NICKNAME_REGEXP}
  
  has_many :questions, dependent: :delete_all

  private

  def nickname_downcase
    nickname&.downcase!
  end
end
