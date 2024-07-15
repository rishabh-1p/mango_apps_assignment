class Showtime < ApplicationRecord
  belongs_to :movie
  has_many :bookings, dependent: :destroy

  def available_seats
    (1..100).to_a - bookings.pluck(:seat_number)
  end
end
