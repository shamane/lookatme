# encoding: UTF-8
class ApplicationController < ActionController::Base
  #protect_from_forgery

  before_filter :init_meta_tags

  protected

  def is_user_admin
    redirect_to user_sign_in_path unless current_user.is_admin?
  end

  def confirmed_user
    user = User.find_by_email(params[:email])
    if user
      render :text => t('controllers.application.user_not_confirmed') unless user.confirmed?
    else
      User.create!(:email => params[:email])
#      render :text => t('controllers.application.email_not_exist')
    end
  end

  def tournaments_are_enabled
    render :text => t('controllers.application.tournaments_are_stoped') unless Settings.are_tournaments_started?
  end

  def init_meta_tags
    set_meta_tags :og => { :url => request.url,
                           :title => 'PUMA After Hours Athletic Games',
                           :description => 'Приймай участь у конкурсі від компанії PUMA та отримай можливість отримати знижку на будь-яку пару кроссівок із нової колекції 2013 року.',
                           :type => 'article',
                           :site_name => 'PUMA After Hours Athletic Games'},
                :fb => { :app_id => '130376893839981'}
  end
end
