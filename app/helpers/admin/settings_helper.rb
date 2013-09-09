module Admin::SettingsHelper
  def change_tournaments_state
    if @settings.state == 'started'
      link_to t('.stop'), admin_setting_stop_path(@settings)
    else
      link_to t('.start'), admin_setting_start_path(@settings)
    end
  end
end
