class Api::V1::ItemsController < ApplicationController

  def index
    render json: ItemSerializer.new(Item.all)
  end

  def show
    render json: ItemSerializer.new(Item.find(params[:id]))
  end

  def create
    render json: ItemSerializer.new(Item.create(item_params))
  end

  def update
    render json: ItemSerializer.new(Item.update(item_params))
  end

  def destroy #when destroying an item, there is no JSON body, and it doesn't utilize a serializer
    Item.destroy(params[:id]) #render status 201
  end

  private
    def item_params
      params.permit(:name, :description, :unit_price, :merchant_id)
    end
end
