class User < ApplicationRecord
  has_secure_password
  validates :password_confirmation, presence: true
  validates :username, presence: true
  validates :username, :uniqueness => true
  validates :first_name, presence: true
  validates :last_name, presence: true
  belongs_to :team
  belongs_to :profile, optional: true
  belongs_to :user_type
  has_many :notes
end
