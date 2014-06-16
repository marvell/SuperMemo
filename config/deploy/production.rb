role :app, %w{marvell@ndr.su}

set :application_domain, 'supermemo.ndr.su'

set :db_user, 'root'
set :db_name, fetch(:application) + '_production'