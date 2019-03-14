class Feature < ApplicationRecord
  validates :feature_name, presence: true
  validates :json_feature_id, presence: true
  has_many :scenarios
  belongs_to :team
end
