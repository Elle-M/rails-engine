class Merchant < ApplicationRecord 
  has_many :items
  has_many :invoices
  validates_presence_of :name

  # def search_params
  #   params.permit(:name, :created_at, :updated_at)
  # end
end
