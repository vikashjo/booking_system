class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :room
  
  validates :start_date, :end_date, :room_id, :user_id, presence: true
  validate :check_room_availability
  validates :end_date, comparison: { greater_than: :start_date,  message: 'Must be greater than the check in date' }

  def check_room_availability
    if room && room.bookings.exists?(['start_date < ? AND end_date > ?', end_date, start_date])
      errors.add(:base, 'Selected dates are not available for booking')
    end
  end
end
