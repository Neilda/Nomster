class PlacesController < ApplicationController
	def index
		@places = Place.order("name").page(params[:page]).per(3)
	end

	def new
		@place = Place.new
	end

	def create
		Place.create(place_params)
#		ActiveRecord::Base.connection.execute("insert into places(name, address, description) value(?,?,?)", params[:place][:name], params[:place][:address], params[:place][:description])
		redirect_to root_path
	end

	private

	def place_params
		params.require(:place).permit(:name, :address, :description)
	end

end
