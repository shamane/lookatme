class Admin::VotesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :is_user_admin
  before_filter :find_discipline
  before_filter :find_vote, :only => [:destroy]

  def index
    @votes = @discipline.votes.confirmed
  end

  def destroy
    @vote.destroy
    redirect_to @discipline
  end

  private

  def find_discipline
    @discipline = Discipline.find_by_id(params[:discipline_id])
  end

  def find_vote
    @vote = @discipline.votes.find_by_id(params[:id])
  end
end
