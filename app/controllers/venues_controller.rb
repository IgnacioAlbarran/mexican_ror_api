require 'platforms'

class VenuesController < ApplicationController
  before_action :set_venue, only: [:show, :update, :destroy]

  # GET /venues
  def index
    @venues = Venue.all

    render json: @venues
  end

  # GET /venues/1
  def show
    render json: @venue
  end

  # POST /venues
  def create
    @venue = Venue.new(venue_params)

    if @venue.save
      render json: @venue, status: :created, location: @venue
    else
      render json: @venue.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /venues/1
  def update
    if @venue.update(venue_params)
      update_platforms(@venue)
      render json: @venue
    else
      render json: @venue.errors, status: :unprocessable_entity
    end
  end

  # DELETE /venues/1
  def destroy
    @venue.destroy
  end

  def platform_a_data
    api = Platforms.new
    render json: api.platform_info_from(Platforms::URL_A)
  end

  def platform_b_data
    api = Platforms.new
    render json: api.platform_info_from(Platforms::URL_B)
  end

  def platform_c_data
    api = Platforms.new
    render json: api.platform_info_from(Platforms::URL_C)
  end

  def update_platforms(venue)
    api = Platforms.new
    api.change_platforms(venue)
  end

  private

    def set_venue
      @venue = Venue.find(params[:id])
    end

    def venue_params
      params.require(:venue).permit(:name, :address_line_1, :address_line_2, :website, :phone_number, :lat, :lng, :category_id_a, :category_id_b, :closed, :hours)
    end
end
