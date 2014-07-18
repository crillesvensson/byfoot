class PlacesController < ApplicationController
  def index
    if params[:id] != nil
      @user = User.find(params[:id])
    else
      @user = current_user
    end
      @places = @user.places
      @hash = Gmaps4rails.build_markers(@places) do |place, marker|
      marker.lat place.latitude
      marker.lng place.longitude
	end

  end

  def new
  	@user = current_user
  	@place = @user.places.new
  end

  def findplace
    @user = current_user
    @client = GooglePlaces::Client.new('AIzaSyBc1aKSdIj4Y4pszwFHO8cPxXY3llVf6Us')
    if params[:search] != nil
      location = Geocoder.coordinates(params[:search])
      if location != nil && (!location.first.blank? && !location.second.blank?)
        types = []
        if params[:food] == 'true'
          types << 'food'
        end
        if params[:airport] == 'true'
          types << 'airport'
        end
        if params[:atm] == 'true'
          types << 'atm'
        end
        if params[:cafe] == 'true'
          types << 'cafe'
        end
        if params[:gym] == 'true'
          types << 'gym'
        end
        if params[:night_club] == 'true'
          types << 'night_club'
        end
        if params[:taxi_stand] == 'true'
          types << 'taxi_stand'
        end
        if params[:shopping_mall] == 'true'
          types << 'shopping_mall'
        end

        if types.size == 0
          types = 'food'
        elsif types.size == 1
          types = types.first
        end

        @spots = @client.spots(location.first, location.second, :types => types)
        if @spots.blank? || @spots.size == 0
          @places = []
          flash[:notice] = "No place found, try again"
          render action: 'findplace'
        else
          @places = []
          @spots.each do |spot|
            place = Place.new
            place.name = spot.name
            place.latitude = spot.lat
            place.longitude = spot.lng
            place.address = spot.vicinity
            @places << place
          end
        end
      else
        @places = []
        flash[:notice] = "No place found, try again"
        render action: 'findplace'
      end
    else
      @places = []
    end
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

  def userindex
    @places = Place.where( "latitude = ? AND longitude = ?", params[:latitude], params[:longitude] )
    @place = @places.first
    @users = []
    @places.each do |place|
      if place.user_id != current_user.id
        @users << User.find(place.user_id)
      end
    end

    @hash = Gmaps4rails.build_markers(@place) do |place, marker|
      marker.lat place.latitude
      marker.lng place.longitude
    end

  end

  def showspot
    places = []
    @place = Place.new
    @place.name = params[:name]
    @place.address = params[:address]
    @place.latitude = params[:lat]
    @place.longitude = params[:lng]
    places << @place
    @hash = Gmaps4rails.build_markers(places) do |place, marker|
      marker.lat place.latitude
      marker.lng place.longitude
    end
  end

  def edit
  	@place = Place.find(params[:id])
  end

  def show
    @user = User.find(params[:user_id])
  	@place = Place.find(params[:id])
  	@images = @place.images
  	@image = Image.new	
  end

  def update
  	@place = Place.find(params[:id])
    if @place.update(place_params)
        if @place.longitude.blank? || @place.latitude.blank?
          @place.destroy
          flash[:notice] = "Place not found, try again"
          render action: 'edit'
        else
          redirect_to places_path
        end
    else
        render action: 'edit'
    end

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
  	redirect_to show_place_path(id: @place.id, user_id: current_user.id)
  end

  def showimage
    @user = User.find(params[:user_id])
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
      redirect_to show_place_path(id: @place.id, user_id: current_user.id)
    else
      render 'editimage'
    end
  end

  def destroyimage
  	@place = Place.find(params[:place_id])
  	@image = Image.find(params[:image_id])
  	@image.destroy
  	redirect_to show_place_path(id: @place.id, user_id: current_user.id)
  end

  private 

  def place_params
  	params.require(:place).permit(:name, :address, :longitude, :latitude, :user_id)
  end

  def image_params
  	params.require(:image).permit(:title, :description, :place_id, :image)
  end
end
