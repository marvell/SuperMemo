namespace :deploy do
  namespace :nginx do
    %w(start stop restart).each do |cmd|
      task cmd do
        on release_roles :all do
          sudo '/etc/init.d/nginx', cmd
        end
      end
    end
  end
end