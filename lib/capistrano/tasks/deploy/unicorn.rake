namespace :deploy do
  namespace :unicorn do
    task :start do
      on release_roles :all do
        within current_path do
          sudo :unicorn_rails, '-E production', '-c config/unicorn.rb'
        end
      end
    end
  end
end