class MetaTagsSoc
include Rails.application.routes.url_helpers
  def initialize(opt = {})
    @discipline = opt[:discipline]
#    @soc_type = opt[:soc_type]
    @request = opt[:request]
  end

  def generator()
#    path = @soc_type == 'fb' ? 'fb.jpg' : 'vk.jpg'
#    image = @request.base_url + ActionController::Base.helpers.asset_path(path)

    { :og => { :url => discipline_url(@discipline),
#discipline_url(:id => @discipline, :lol => 'lol' ) ,
               :title => @discipline.name,
               :description => @discipline.description }
    }
  end
end
