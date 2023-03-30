class ErrorSerializer < ActiveModel::Serializer
  attr_reader :message, 
              :errors

  def message
    object.message
  end

  def errors
    object.errors
  end
end
