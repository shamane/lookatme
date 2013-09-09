# encoding: UTF-8
class VotesController < ApplicationController
  before_filter :tournaments_are_enabled
  before_filter :confirmed_user
  before_filter :find_vote
  before_filter :find_vote_token

  def confirm
    @vote.confirm!
    render :text => "Голос подтверджон"
  end

  private

  def find_vote
    @vote = Vote.unscoped.find_by_id(params[:id])
  end

  def find_vote_token
    @vote = Vote.unscoped.find_by_confirmation_token(params[:confirmation_token])
  end
end
