namespace :postgres do
  desc 'postgres'
  task :start do
    on roles(:app) do
      execute "sudo service postgresql start"
    end
  end

  task :stop do
    on roles(:app) do
      execute "sudo service postgresql stop"
    end
  end

  task :restart do
    on roles(:app) do
      execute "sudo service postgresql restart"
    end
  end
end
