class Api::V1::MerchantsController < ApplicationController
  def index
    render json: Merchant.all
  end

  def show
    render json: Merchant.find(params[:id])
    all_items = Item.where(merchant_id: params[:id])
  end
end
