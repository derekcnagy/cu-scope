class Note < ApplicationRecord
  validate :tied_to_one_and_only_one
  validates :note, presence: true
  belongs_to :scenario, optional: true
  belongs_to :individual_test, optional: true
  belongs_to :error_message, optional: true
  belongs_to :team
  belongs_to :user

  def tied_to_one_and_only_one
    attached_count = 0
    attached_count += 1 unless scenario.nil?
    attached_count += 1 unless individual_test.nil?
    attached_count += 1 unless error_message.nil?
    unless attached_count.eql? 1
      errors.add(:base, "Must be attached to one and ONLY one of either Scenario, Individual Test, or Error Message")
    end
  end
end
