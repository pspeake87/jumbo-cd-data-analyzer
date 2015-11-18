# config valid only for current version of Capistrano
lock '3.4.0'

set :application, 'jumbo-cd-data-analyzer'
set :repo_url, 'git@github.com:pspeake87/jumbo-cd-data-analyzer.git'

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, '/var/www/my_app_name'

# Default value for :scm is :git
set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml', 'config/application.yml')

# Default value for linked_dirs is []
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
set :keep_releases, 5

namespace :deploy do

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

  desc 'reset db'
  task :dbreset do
    on roles(:app), in: :sequence, wait: 5 do
      within "#{deploy_to}/current" do
        with rails_env: :production do
          # commands in this block execute with the environment
          # variable RAILS_ENV=production
          rake   "db:reset"
        end
      end
    end
  end

  desc 'Restart application'
  task :restart do
    # Reload unicorn with capistrano3-unicorn hook
    # needs to be before "on roles()"
    invoke 'unicorn:legacy_restart'
    # invoke 'unicorn:restart'
    # on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
    # end
  end

  # As of Capistrano 3.1, the `deploy:restart` task is not called
  # automatically.
  after :finishing, 'deploy:cleanup'
  before :finishing, 'deploy:restart'
  after 'deploy:rollback', 'deploy:restart'

end
