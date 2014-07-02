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
	if @place.save
	  	if @place.longitude.blank? || @place.latitude.blank?
	  		@place.destroy
	  		flash[:notice] = "Place not found, try again"
	  		render action: 'new'
	  	else
	  		redirect_to places_path
	  	end
	else
	  	render action: 'new'
	end
  	
  end

  def edit
  	
  end

  def show
  	@place = Place.find(params[:id])
  	@images = @place.images
  	@image = Image.new	
  end

  def update
  	
  end

  def destroy
  	@place = Place.find(params[:id])
  	@place.destroy
  	redirect_to places_path
  end

  def addimage
  	@place = Place.find(params[:place_id])
  	@image = @place.images.build(image_params)
  	@image.save
  	redirect_to place_path(@place)
  end

  def showimage
  	@place = Place.find(params[:place_id])
  	@image = Image.find(params[:image_id])
  end

  def editimage
  	@place = Place.find(params[:place_id])
  	@image = Image.find(params[:image_id])
  end

  def updateimage
  	@place = Place.find(params[:place_id])
  	image = Image.find(params[:image_id])

    if image.update(image_params)
      redirect_to place_path(@place)
    else
      render 'editimage'
    end
  end

  def destroyimage
  	@place = Place.find(params[:place_id])
  	@image = Image.find(params[:image_id])
  	@image.destroy
  	redirect_to place_path(@place)
  end

  private 

  def place_params
  	params.require(:place).permit(:name, :address, :longitude, :latitude, :user_id)
  end

  def image_params
  	params.require(:image).permit(:title, :description, :place_id, :image)
  end
end
