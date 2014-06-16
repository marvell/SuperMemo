# config valid only for Capistrano 3.1
lock '3.2.1'

set :application, 'supermemo'

set :scm, :git
set :repo_url, 'git@github.com:marvell/SuperMemo.git'
set :branch, 'master'

set :deploy_to, '/home/marvell/apps/supermemo.ndr.su'
set :template_dir, 'config/deploy/templates'

# set :rvm_type, :user
# set :rvm_ruby_version, '2.1.2'

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

set :linked_files, %w{config/database.yml config/unicorn.rb}
set :linked_dirs, %w{tmp/pids tmp/cache tmp/sockets log}

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5