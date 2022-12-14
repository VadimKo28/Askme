class User < ApplicationRecord
  has_secure_password

  before_validation :attribute_downcase

  NICKNAME_REGEXP = /\A[a-z0-9\_]+\z/
  EMAIL_REGEXP = /\A[a-z0-9\.]+@[a-z0-9]+\.[a-z]+\z/

  validates :email, presence: true, uniqueness: true, format: { with: EMAIL_REGEXP }
  validates :nickname, presence: true, length: { maximum: 40 }, uniqueness: true, format: { with: NICKNAME_REGEXP }
  validates :header_color, format: { with: /\A#([a-f\d]{3}){1,2}\z/i }
  
  has_many :questions, dependent: :delete_all
  has_many :asked_questions, class_name: "Question", 
    foreign_key: :author_id, dependent: :nullify

  def to_param 
    nickname
  end 
  
    private

  def attribute_downcase
    nickname&.downcase!
    email&.downcase!
  end
end
