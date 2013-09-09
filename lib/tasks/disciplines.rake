namespace :disciplines do
  # disciplines:create
  desc "add fakes disciplines"
  task :create => :environment do

    user = User.find_by_email('admin@lookatme.ru')
    user.disciplines.create(:name => 'test1', :description => 'test1', :state => 'approved')
    user.disciplines.create(:name => 'test2', :description => 'test2', :state => 'approved')
    user.disciplines.create(:name => 'test3', :description => 'test3', :state => 'approved')
  end
end
