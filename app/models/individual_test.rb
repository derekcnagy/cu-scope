class IndividualTest < ApplicationRecord
  validates :passed, :inclusion => { :in => [true, false] }
  validates :duration, presence: true
  belongs_to :test_run
  belongs_to :scenario
  belongs_to :error_message, optional: true
  validates :error_message, :presence => true, :unless => :passed
  validates_absence_of :error_message, :if => :passed
  has_many :notes
end
