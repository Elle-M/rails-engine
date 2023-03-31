class Api::V1::ItemsSearchController < ApplicationController
  def index
    if render json: ItemSerializer.new(Item.where(search_params))
    else
      render json: { error: "No items found"}, status: 404
    end
  end

private
  def search_params
    params.permit(:name, :description, :unit_price, :merchant_id, :created_at, :updated_at)
  end

  def find_by_name
    name = params[:name]
    if name
      render json: ItemSerializer.new(Item.where('lower(name) ILIKE ?', name)).order(:name).first
    else
      render json: { error: "No items found"}, status: 404
    end
  end

  def find_by_price
    if permitted_params[:min_price]
      render json: ItemSerializer.new(Item.where('unit_price >= ?', permitted_params[:min_price]))
    elsif permitted_params[:max_price]
      render json: ItemSerializer.new(Item.where('unit_price <= ?', permitted_params[:max_price]))
    end
end