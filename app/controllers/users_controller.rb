# frozen_string_literal: true

# Users Controller
class UsersController < ApplicationController
  def index
    users = User.all
    render json: users
  end

  def create
    @user = User.create(user_params)
    if @user.save
      render json: @user, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end
