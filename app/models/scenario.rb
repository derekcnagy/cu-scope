class Scenario < ApplicationRecord
  validates :scenario_name, presence: true
  validates :steps, presence: true
  validates :json_scenario_id, presence: true
  belongs_to :feature
  has_many :individual_tests
  has_many :notes
end
