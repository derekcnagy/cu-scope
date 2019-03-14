class ErrorMessage < ApplicationRecord
  validates :error_message, presence: true
  has_many :individual_tests
  has_many :notes
end
