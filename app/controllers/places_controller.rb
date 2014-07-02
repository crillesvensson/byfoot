class PlacesController < ApplicationController
  def index

  	@places = current_user.places
	@hash = Gmaps4rails.build_markers(@places) do |place, marker|
	  marker.lat place.latitude
	  marker.lng place.longitude
	end

  end

  def new
  	@user = current_user
  	@place = @user.places.new
  end

  def create
  	@user = current_user
  	@place = @user.places.build(place_params)
  	if @place.longitude.blank? || @place.latitude.blank?
  		flash[:notice] = "Place not found, try again"
  		render action: 'new'
  	else
	  	if @place.save
	  		redirect_to places_path
	  	else
	  		render action: 'new'
	  	end
	end
  	
  end

  def edit
  	
  end

  def show
  	
  end

  def update
  	
  end

  def destroy
  	
  end

  private 

  def place_params
  	params.require(:place).permit(:name, :address, :longitude, :latitude, :user_id)
  end
end
