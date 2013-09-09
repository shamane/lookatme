class Admin::DisciplinesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :is_user_admin
  before_filter :find_discipline, :except => [:index]

  def index
    @confirmed_disciplines = Discipline.confirmed
    @approved_disciplines = Discipline.approved
  end

  def show
    @votes = @discipline.votes
  end

  def destroy
    @discipline.destroy
    redirect_to :action => :index
  end

  def approve
    @discipline.approve!
    @discipline.save
    redirect_to :action => :index
  end

  def reject
    @discipline.reject!
    @discipline.save
    redirect_to :action => :index
  end

  def winners
    @winners_disciplines = Discipline.approved.winners.notnull
  end

  def send_notification_to_winners
    @winners = Discipline.approved.winners.notnull
    @winners.each do |winner|
      winner.send_emails
    end
    redirect_to :action => :index
  end


  private

  def find_discipline
    @discipline = Discipline.find_by_id(params[:id])
  end
end



