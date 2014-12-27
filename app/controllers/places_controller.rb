class PlacesController < ApplicationController
	before_action :authenticate_user!, :only => [:new, :create, :edit, :update, :destroy]

	def index
		@places = Place.order("name").page(params[:page]).per(3)
	end

	def new
		@place = Place.new
	end

	def create
		current_user.places.create(place_params)
		redirect_to root_path
	end

	def show
		@place = Place.find(params[:id])
	end

	def edit
		@place = Place.find(params[:id])

		if @place.user != current_user
			return render :text => 'Not Allowed', :status => :forbidden
		end
	end

	def update
		@place = Place.find(params[:id])
		if @place.user != current_user
			return render :text => 'Not Allowed', :status => :forbidden
		end
		@place.update_attributes(place_params)
		redirect_to root_path
	end

	def destroy
		# When we destroy a place we want to do three things:

		# Find the right place.
#		@place = Place.find(params[:id])
		# Destroy the place from our database.
#		@place.destroy
		# Send the user to the root path.
#		redirect_to root_path
  @place = Place.find(params[:id])
  if @place.user != current_user
  	return render :text => 'Not Allowed', :status => :forbidden
  end

  @place.destroy

redirect_to root_path
	end

	private

	def place_params
		params.require(:place).permit(:name, :address, :description)
	end

end

#		ActiveRecord::Base.connection.execute("insert into places(name, address, description) value(?,?,?)", params[:place][:name], params[:place][:address], params[:place][:description])