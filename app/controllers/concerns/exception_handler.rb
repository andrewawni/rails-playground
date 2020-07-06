module ExceptionHandler
  extend ActiveSupport::Concern

  class AuthenticationError < StandardError; end

  included do
    rescue_from ExceptionHandler::AuthenticationError do |e|
      render json: { message:'custom message' }, status: 900
    end

    rescue_from Mongoid::Errors::DocumentNotFound do |e|
      json_response({ message: e.message }, :not_found)
    end

    rescue_from Mongoid::Errors::Validations do |e|
      json_response({ message: e.message }, :unprocessable_entity)
    end
    
  end
end