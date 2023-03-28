class Api::V1::ItemsController < ApplicationController 
   def index
    render json: Item.all
    # render json: ItemSerializer.new(@merchant.items).serializable_hash.to_json
  end

  def show
    render json: Item.find(params[:id])
  end

  def create
    new_item = Item.new(item_params)
    if new_item.save
    render json: Item.create(item_params), status: 201
    end
  end

  def update
    item = Item.find(params[:id])
    if Merchant.exists?(item_params[:merchant_id])
      item.update(item_params)
      render json: item, status: 200
    else
      render json: {error: "Merchant does not exist"}, status: 400
    end
  end

  def destroy
    render json: Item.destroy(params[:id])
  end

  private
  
  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
  end
end