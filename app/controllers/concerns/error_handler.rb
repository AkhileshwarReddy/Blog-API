module ErrorHandler
  extend ActiveSupport::Concerns

  included do
    rescue_from ApplicationError, with: :render_error
    rescue_from ActiveRecord::RecordNotFound, with: :render_error
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity
    rescue_from StandardError, with: :render_internal_server_error
  end

  private

  def render_error(exception)
    render json: { error: exception.error, message: exception.message }, status: exception.status
  end

  def render_unprocessable_entity(exception)
    render json: {
      error: :unprocessable_entity,
      message: exception.record.errors.full_messages.join(', '),
      status: 422
    }
  end

  def render_internal_server_error
    render json: {
      error: :internal_server_error,
      message: 'Something went wrong',
      status: 500
    }

    Rails.logger.error(exception.message)
    Rails.logger.error(exception.backtrace.join("/n"))
  end
end