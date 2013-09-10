namespace :admin do
  # admin:create
  desc "add admin role to user with specific email"
  task :create => :environment do
    user = User.create( :email => 'admin@lookatme.lu',
                        :password => '12345678',
                        :password_confirmation => '12345678')
    user.confirm!
  end
end
