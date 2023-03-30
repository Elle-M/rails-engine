class Api::V1::MerchantsSearchController < ApplicationController
  def show
    if search_params[:name]
      find_by_name
    else
      render json: MerchantSerializer.new(Merchant.find_by(search_params))
    end
  end  


private

  def search_params
    params.permit(:name)
  end

  def find_by_name
    name = params[:name]
    if name
      merchant = Merchant.where('lower(name) = ?', name.downcase).order(:name).first
    else
      merchant = Merchant.first
    end
    if merchant 
      render json: MerchantSerializer.new(merchant)
    else
      render json: { error: "No merchant found"}, status: 404
    end
  end
end