class OffersController < ApplicationController
  before_action :set_buyer

  def index
    @offers = @buyer.offers
  end

  def show
    @offer = @buyer.offers.find(params[:id])
  end

  def new
    @offer = Offer.new
  end

  def create
    @offer = Offer.new(offer_params)
    @artwork = Artwork.find(params[:artwork_id])
    @offer.artwork = @artwork
    @offer.buyer = @buyer
    if @offer.save
      redirect_to @artwork
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_buyer
    @buyer = current_user
  end

  def offer_params
    params.require(:offer).permit(:amount, :artwork_id)
  end
end
