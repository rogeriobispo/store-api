class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ValidationException, with: :validation

  def record_not_found(error)
    render json: { errors: [error] }, status: :not_found
  end

  def validation(error)
    render json: { errors: [error] }, status: :unprocessable_entity
  end
end
