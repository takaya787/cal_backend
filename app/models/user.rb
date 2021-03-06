class User < ApplicationRecord
  has_many :events, dependent: :destroy
  has_many :tasks, dependent: :destroy
  has_secure_password

  validates(:name, presence: true,length: {maximum: 50 })
  validates(:email, presence: true, length: { maximum: 255 },  uniqueness: { case_sensitive: false })
  validates(:password, presence: true, length: { minimum: 6 }, allow_nil: true,)
end
