class Api::V1::MerchantsController < ApplicationController
  def index
    render json: Merchant.all
    # render json: MerchantSerializer.new(Merchant.all).serializable_hash.to_json
  end

  def show
    @merchant = Merchant.find(params[:id])
    @items = @merchant.items

    render json: Merchant.find(params[:id])
    # render json: MerchantSerializer.new(Merchant.find(params[:id])).serializable_hash.to_json
  end
end
