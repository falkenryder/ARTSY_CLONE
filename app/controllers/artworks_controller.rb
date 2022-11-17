class ArtworksController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]

  def index
    if user_signed_in?
      @artworks = Artwork.where(owner_id: params[:user_id])
    else
      @artworks = Artwork.all
    end
  end

  def show
    @artwork = Artwork.find(params[:id])
  end

  def new
    @artwork = Artwork.new
  end

  def create
    @artwork = Artwork.new(artwork_params)
    if @artwork.save
      redirect_to artwork_path(@artwork)
    else
      render :new
    end
  end

  def destroy
    @artwork = Artwork.find(params[:id])
    @artwork.destroy
    redirect_to artworks_path
  end

  private

  def artwork_params
    params.require(:artwork).permit(:artist_name, :title, :theme, :year, :price, :details)
  end
end
