class Api::V1::MerchantsSearchController < ApplicationController
  def index
    render json: MerchantSerializer.new(Merchant.where(search_params))
  end
end