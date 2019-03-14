class Profile < ApplicationRecord
  validates :profile_name, presence: true
  belongs_to :team
  has_many :test_runs
  has_many :users
end
