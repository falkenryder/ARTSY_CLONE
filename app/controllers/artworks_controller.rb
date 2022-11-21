class ArtworksController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]
  before_action :set_owner

  def index
    if params[:user_id].present?
      @artworks = Artwork.where(owner_id: params[:user_id])
    elsif params[:query].present?
      @artworks = Artwork.search_by(params[:query])
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
    @artwork.owner_id = @owner.id
    if @artwork.save
      redirect_to artwork_path(@artwork)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @artwork = Artwork.find(params[:id])
    @artwork.destroy
    redirect_to artworks_path
  end

  private

  def set_owner
    @owner = current_user
  end

  def artwork_params
    params.require(:artwork).permit(:artist_name, :title, :theme, :year, :price, :details, :photo)
  end
end
