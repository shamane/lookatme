namespace :settings do
  desc "Generate default settings"
  task :generate_default => :environment do
    unless Settings.any?
      Settings.create(:state => :stoped)
    end
  end

end
