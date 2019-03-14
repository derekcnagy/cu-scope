class Team < ApplicationRecord
  validates :team_name, presence: true
  has_many :profiles
  has_many :test_runs
  has_many :users
  has_many :notes
  has_many :features
end
