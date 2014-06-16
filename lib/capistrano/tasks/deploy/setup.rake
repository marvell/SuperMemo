namespace :deploy do
  task :setup do
    invoke 'deploy:setup:base'
    # invoke 'deploy:setup:nginx'
    invoke 'deploy:setup:unicorn'
    # invoke 'deploy:setup:db'
  end

  namespace :setup do
    task :base do
      on release_roles :all do
        execute :mkdir, "-p #{shared_path}/config" unless test "[ -d #{shared_path}/config ]"
      end
    end

    task :nginx do
      on release_roles :all do
        location = fetch(:template_dir, 'config/deploy/templates') + '/nginx_vhost.conf.erb'
        unless File.file?(location)
          error 'nginx_vhost.conf.erb file isn\'t found'
          exit 1
        end
        config = ERB.new(File.read(location))

        upload! StringIO.new(config.result), "#{shared_path}/config/nginx_vhost.conf"

        sudo :ln, '-nfs', "#{shared_path}/config/nginx_vhost.conf", "/etc/nginx/sites-enabled/#{fetch(:application_domain)}"

        invoke 'deploy:nginx:restart'
      end
    end

    task :unicorn do
      on release_roles :all do
        location = fetch(:template_dir, 'config/deploy/templates') + '/unicorn.rb.erb'
        unless File.file?(location)
          error 'unicorn.rb.erb file isn\'t found'
          exit 1
        end
        config = ERB.new(File.read(location))

        upload! StringIO.new(config.result), "#{shared_path}/config/unicorn.rb"

        # sudo :unicorn_rails, :restart
      end
    end

    task :db do
      on release_roles :all do
        set :db_password, ask('database password', 'secure_password')

        location = fetch(:template_dir, 'config/deploy/templates') + '/database.yml.erb'
        unless File.file?(location)
          error 'database.yml.erb file isn\'t found'
          exit 1
        end
        config = ERB.new(File.read(location))

        execute :mkdir, "-p #{shared_path}/db" unless test "[ -d #{shared_path}/db ]"
        upload! StringIO.new(config.result), "#{shared_path}/config/database.yml"
      end
    end
  end
end