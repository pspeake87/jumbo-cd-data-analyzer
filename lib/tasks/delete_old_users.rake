namespace :delete do
  desc 'Delete users older than 30 days'
  task :old_users => :environment do
    User.where('created_at < ?', 30.days.ago).each do |user|
      user.destroy
    end

   
  end
end