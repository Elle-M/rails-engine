class Api::V1::MerchantsSearchController < ApplicationController

  def show
    render json: MerchantSerializer.new(Merchant.find_by(search_params))
  end

# private
  def search_params
    params.permit(:name)
  end
end