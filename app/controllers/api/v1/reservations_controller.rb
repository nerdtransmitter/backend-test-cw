class ReservationsController < ApplicationController
  before_action :set_listing, only: %i[new create]

  def new
    @reservation = Reservation.new
  end

  def create
    @reservation = Reservation.new(reservation_params)
    @reservation.save
  end

  private

  def reservation_params
    params.require(:reservations).permit(:start_date, :end_date)
  end

  def set_listing
    @listing = Listing.find(params[:listing_id])
  end
end
