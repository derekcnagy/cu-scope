class UserType < ApplicationRecord
  validates :type_name, presence: true
  has_many :users
end
