# frozen_string_literal: true

class UnauthorizedError < ApplicationError
  def initialize(message: 'Unauthorized access')
    super(status: 401, error: :unauthorized, message: message)
  end
end
