namespace :redis do
  desc 'redis'
  task :start do
    on roles(:app) do
      execute "sudo service redis-server start"
      p 'You must need to restart sidekiq'
      p 'To restart sidekiq run command \'cap production sidekiq:restart\''
    end
  end

  task :stop do
    on roles(:app) do
      execute "sudo service redis-server stop"
    end
  end

  task :restart do
    on roles(:app) do
      execute "sudo service redis-server restart"
    end
  end
end
