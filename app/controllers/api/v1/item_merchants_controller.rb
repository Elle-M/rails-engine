class Api::V1::ItemMerchantsController < ApplicationController
  def index
    item = Item.find(params[:item_id])
    render json: item.merchant
    # render json: Item.find(params[:item_id]).merchant
  end
end