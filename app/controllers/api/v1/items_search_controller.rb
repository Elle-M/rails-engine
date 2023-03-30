class Api::V1::ItemsSearchController < ApplicationController
  def index
    render json: ItemSerializer.new(Item.where(search_params))
  end
  
private
  def search_params
    params.permit(:name, :description, :unit_price, :merchant_id, :created_at, :updated_at)
  end
end