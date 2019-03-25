class Note < ApplicationRecord
  validate :tied_to_either_scenario_or_test_not_both
  validates :note, presence: true
  belongs_to :scenario, optional: true
  belongs_to :individual_test, optional: true
  belongs_to :error_message
  belongs_to :team
  belongs_to :user

  def tied_to_either_scenario_or_test_not_both
    unless scenario.nil?
      unless individual_test.nil?
        errors.add(:base, "If note is attached to a Scenario it must NOT have an attached Individual Test")
      end
    end
    unless individual_test.nil?
      unless scenario.nil?
        errors.add(:base, "If note is attached to an Individual Test it must NOT have an attached Scenario")
      end
    end
  end
end
