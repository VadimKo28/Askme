class User < ApplicationRecord
  has_secure_password

  before_save :nickname_downcase

  has_many :questions, dependent: :delete_all
  
  validates :email, presence: true, uniqueness: true

  def nickname_downcase 
    nickname.downcase!
  end
end
