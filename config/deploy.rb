# config valid only for Capistrano 3.1
lock '3.2.1'

set :application, 'supermemo'

set :scm, :git
set :repo_url, 'git@github.com:marvell/SuperMemo.git'
set :branch, 'master'

set :deploy_to, '/var/www/supermemo'

set :rvm_type, :user
set :rvm_ruby_version, '2.1.2'

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

set :linked_files, %w{config/database.yml}
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :finishing, 'deploy:cleanup'
end
