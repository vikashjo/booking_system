class Room < ApplicationRecord
  has_many :bookings
  has_many :users, through: :bookings
  has_many_attached :images
end
