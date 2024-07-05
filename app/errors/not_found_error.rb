# frozen_string_literal: true

class NotFoundError < ApplicationError
  def initialize(message: 'Resource not found')
    super(status: 404, error: :not_found, message: message)
  end
end
