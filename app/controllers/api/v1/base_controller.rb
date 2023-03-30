class Api::V1::BaseController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActiveRecord::RecordInvalid, with: :record_invalid

  def record_not_found(error)
    render json: ErrorSerializer.new(error), status: :not_found
  end

  def record_invalid(error)
    render json: ErrorSerializer.new(error), status: :unprocessable_entity
  end
end