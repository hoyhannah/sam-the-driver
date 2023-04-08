# frozen_string_literal: true

# Authenticable
module Authenticable
  extend ActiveSupport::Concern

  included do
    before_action :authenticate_request!
    attr_reader :current_user
  end

  private

  def authenticate_request!
    @current_user = User.find_by(id: decoded_auth_token['user_id'].to_i) if decoded_auth_token
    render json: { error: 'Not Authorized' }, status: 401 unless @current_user
  rescue JWT::VerificationError, JWT::DecodeError
    render json: { error: 'Not Authorized' }, status: 401
  end

  def auth_token
    request.headers['Authorization'].split(' ').last
  end

  def decoded_auth_token
    @decoded_auth_token ||= JsonWebToken.decode(auth_token)
  end
end
