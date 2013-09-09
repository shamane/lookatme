class Admin::SettingsController < ApplicationController
  before_filter :is_user_admin
  before_filter :get_settings

  def start
    @settings.tournament_start!
    @settings.save
    redirect_to :action => :index
  end

  def stop
    @settings.tournament_stop!
    @settings.save
    redirect_to :action => :index
  end

  private

  def get_settings
    @settings = Settings.first
  end
end
