# frozen_string_literal: true

# Sessions Controller
class SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      jwt = JWT.encode({ user_id: user.id }, Rails.application.secrets.secret_key_base)
      render json: { jwt: jwt }
    else
      render json: { error: 'Invalid email or password' }, status: :unprocessable_entity
    end
  end
end
