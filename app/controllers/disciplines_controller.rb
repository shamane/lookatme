# encoding: UTF-8
class DisciplinesController < ApplicationController
  before_filter :tournaments_are_enabled, :only => [:like]
  before_filter :find_discipline, :except => [:index]
  before_filter :confirmed_user, :except => [:index,:show]

  def index
    status = Settings.first.state
    if status == 'started'
      @disciplines = Discipline.approved
      render :template => "disciplines/index_approved.xml.builder"
    elsif status == 'stoped'
      @disciplines = Discipline.winners
      render :template => "disciplines/index_winners.xml.builder"
    end
  end

  def confirm
    @discipline.confirm!
    render :text => 'Дисциплина подтверджена'
  end

  def like
    @user = User.find_by_email(params[:email])
    @vote = Vote.unscoped.upcoming(@user.id, params[:id])

    if @vote.count == 0
      @discipline.vote_up(@user)
    end
  end

  def show
    meta_info = MetaTagsSoc.new({ :discipline => @discipline, 
                                  #:soc_type => params[:soc], 
                                  :request => request })
    set_meta_tags(meta_info.generator)
  end

  private

  def find_discipline
    @discipline = Discipline.find_by_id(params[:id])
  end


end
