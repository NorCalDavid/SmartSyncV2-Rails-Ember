module Api
  class propertysController < ApplicationController

    def index
      @properties = User.find(session[:user_id]).properties
    end

    def new
      @property = Property.new
    end

    def create
      property = Property.new(property_params)
      if property.save
        User.find(session[:user_id]).properties.create!(property: property)
        redirect_to property
      else
        render 'new'
      end

    end

    def show
      @property = Property.find(params[:id])
    end

    def edit
      @property = Property.find(params[:id])
    end

    def update
       property = Property.find(params[:id])

      if property.update(property_params)
        redirect_to property
      else
        render 'edit'
      end
    end

    def destroy
      property = Property.find(params[:id])
      if property.destroy
        redirect_to user_path
      else
        false
        status 417
      end

    end

  private

    def property_params
      params.require(:property).permit(:name, :description, :address, :city, :state, :zip_code)
    end

  end
end
