class Api::V1::MissionsController < Api::V1::BaseController
  # before_action :set_mission
  before_action :set_listing, only: %i[create classify calc_price]

  # def new
  #   @mission = Mission.new
  # end

  def index
    @missions = generate_missions
  end

  # def create
  #   @mission = Mission.new
  #   classify
  #   calc_price
  #   if @mission.save
  #     render json: @mission, status: :created
  #   else
  #     render json: @mission.errors, status: :unprocessable_entity
  #   end
  # end

  # private

  # def classify
  #   Booking.all.each do |b|
  #     if b.start_date
  #       @mission.date = b.start_date
  #       @mission.mission_type = 'first_checkin'
  #     elsif b.end_date
  #       @mission.date = b.end_date
  #       @mission.mission_type = 'last_checkout'
  #     else
  #       Reservation.all.each do |r|
  #         if r.end_date && !b.end_date
  #           @mission.date = r.end_date
  #           @mission.mission_type = 'checkout_checkin'
  #         end
  #       end
  #     end
  #   end
  # end

  # def calc_price
  #   case @mission.mission_type
  #   when 'first_checkin' || 'checkin_checkout'
  #     @mission.price = 10 * @listing.num_rooms
  #   when 'last_checkout'
  #     @mission.price = 5 * @listing.num_rooms
  #   end
  # end

  def generate_missions
    @missions = []
    Booking.all.each do |booking|
      if booking.start_date
        @mission = Mission.new(date: booking.start_date, mission_type: 'first_checkin', price: 10 * booking.listing.num_rooms, listing_id: booking.listing.id )
        @missions << @mission
      end
      if booking.end_date
        @mission = Mission.new(date: booking.end_date, mission_type: 'last_checkout', price: 5 * booking.listing.num_rooms, listing_id: booking.listing.id)
        @missions << @mission
      end
      Reservation.all.each do |reservation|
        bookings = reservation.listing.bookings
        if reservation.end_date && !bookings.any? {|b| b.end_date == reservation.end_date }
          @mission = Mission.new(date: reservation.end_date, mission_type: 'checkout_checkin', price: 10 * reservation.listing.num_rooms, listing_id: booking.listing.id)
          @missions << @mission
        end
      end
    end
    @missions
  end

  def set_listing
    @listing = Listing.find(params[:id])
  end

  def mission_params
    params.require(:missions).permit(:date, :mission_type, :price)
  end
end
