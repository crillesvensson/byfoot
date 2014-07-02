class Place < ActiveRecord::Base

	has_many :images, dependent: :destroy
	belongs_to :user

	geocoded_by :address
	after_validation :geocode

end
