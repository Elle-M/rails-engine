class Api::V1::ItemsController < ApplicationController 
   def index
    render json: ItemSerializer.new(Item.all)
  end

  def show
    render json: ItemSerializer.new(Item.find(params[:id]))
  end

  def create
    new_item = Item.new(item_params)
    if new_item.save
    render json: ItemSerializer.new(new_item), status: 201
    end
  end

  def update
    item = Item.find(params[:id])
    if Merchant.exists?(item_params[:merchant_id]) || item_params[:merchant_id] == nil
      item.update(item_params)
      render json: ItemSerializer.new(item), status: 200
    else
      render json: {error: "Merchant does not exist"}, status: 400
    end
  end

  def destroy
    item = Item.find(params[:id])
    item.destroy
    render json: {message: "Item #{item.id} has been deleted."}, status: 204
  end

  private
  
  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
  end
end