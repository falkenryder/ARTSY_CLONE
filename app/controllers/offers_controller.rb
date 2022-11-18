class OffersController < ApplicationController
  before_action :set_buyer

  def index
    if params[:artwork_id]
      set_artwork
      @offers = @artwork.offers
    elsif params[:user_id]
      set_seller
      @offers = []
      @seller.artworks.each { |artwork| @offers << artwork.offers }
      @offers.flatten!
    else
      @offers = @buyer.offers
    end
  end

  def show
    @offer = Offer.find(params[:id])
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

  def update
    @artwork = Artwork.find(params[:artwork_id])
    @offer = Offer.find(params[:id])
    @offer.status = params[:offer][:status]
    if @offer.save
      @artwork.offers.map do |offer|
        unless offer.id == @offer.id
          offer.status = "rejected"
          offer.save!
        end
      end
    end
    redirect_to artwork_offers_path(@artwork)
  end

  private

  def set_buyer
    @buyer = current_user
  end

  def set_artwork
    @artwork = Artwork.find(params[:artwork_id])
    @seller = User.find(@artwork.owner_id)
  end

  def set_seller
    @seller = User.find(params[:user_id])
  end

  def offer_params
    params.require(:offer).permit(:amount, :artwork_id)
  end
end
