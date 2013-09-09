# encoding: UTF-8
class ConfirmationsController < ApplicationController
  before_filter :tournaments_are_enabled
  before_filter :find_user

  def confirm
    @user.confirm!
    render :text => 'Екаунт подвержон'
  end

  def find_user
    @user = User.find_by_confirmation_token(params[:token])
  end
end
