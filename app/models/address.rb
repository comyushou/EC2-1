class Address < ApplicationRecord
	 belongs_to :user

	  validates :user_id,:postal_code,:address,:name, presence: true
end

