class Api::V1::MerchantItemsController < ApplicationController
  def index
    # begin
    render json: ItemSerializer.new(Merchant.find(params[:merchant_id]).items), status: 200

    # rescue ActiveRecord::RecordNotFound => e
    #   redirect_to '/404'
    # end
  end  
end