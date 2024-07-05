# frozen_string_literal: true

class ApplicationError < StandardError
  attr_reader :status, :message, error

  def initialize(status: 500, error: :application_error, message: 'Something went wrong')
    @status = status
    @message = message
    @error = error
  end
end
