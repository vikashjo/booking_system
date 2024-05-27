class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :room
  
  validates :start_date, :end_date, :room_id, :user_id, presence: true
  validate :end_date_after_start_date
  validate :check_room_availability


  def end_date_after_start_date
    return if start_date.blank? || end_date.blank?

    if end_date <= start_date
      errors.add(:end_date, "must be after the start date")
    end
  end

  def check_room_availability
    if room && room.bookings.exists?(['start_date < ? AND end_date > ?', end_date, start_date])
      errors.add(:base, 'Selected dates are not available for booking')
    end
  end
end
