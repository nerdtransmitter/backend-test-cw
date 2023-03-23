class Api::V1::ListingsController < Api::V1::BaseController
  before_action :set_listing, only: %i[show edit update delete]

  # def new
  #   @listing = Listing.new
  # end

  def create
    @listing = Listing.new(listing_params)
    @listing.save
  end

  def show
  end

  def index
    @listings = Listing.all
  end

  # def edit
  # end

  def update
    @listing.update(listing_params)
    redirect_to listing_path(@listing)
  end

  def delete
    @listing.destroy
    redirect_to listings_path, status: :see_other
  end

  private

  def listing_params
    params.require(:listings).permit(:num_rooms)
  end

  def set_listing
    @listing = Listing.find(params[:listing_id])
  end
end
