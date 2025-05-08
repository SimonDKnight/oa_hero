class License < ApplicationRecord
  belongs_to :user

  validates :license_key, presence: true, uniqueness: true
  validates :plan, presence: true
end
