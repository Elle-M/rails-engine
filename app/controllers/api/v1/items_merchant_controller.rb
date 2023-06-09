class Api::V1::ItemsMerchantController < ApplicationController
  def index
    item = Item.find(params[:item_id])
    if Item.exists?(params[:item_id])
      render json: MerchantSerializer.new(Merchant.find(item.merchant_id)), status: 200
    else
      render json: {error: "Item does not exist"}, status: 404
    end
  end
end