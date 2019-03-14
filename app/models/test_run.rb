class TestRun < ApplicationRecord
  validates :test_run_name, presence: true
  validates :time_ran, presence: true
  has_many :individual_tests
  belongs_to :team
  belongs_to :profile, optional: true
end
