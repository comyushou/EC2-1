class Oder < ApplicationRecord
  belongs_to :user

  has_many :oreder_items
end
