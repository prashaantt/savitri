namespace :sidekiq do
  task :start do
    on roles(:app) do
      execute "cd #{current_path} && bundle exec sidekiq -c 10 -e production -L log/sidekiq.log -d"
    end
  end

  task :stop do
    on roles(:app) do
      execute "ps aux | grep 'sidekiq 2.6.0 savitri' | awk '{print $2}' | sed -n 1p | xargs kill -9"
    end
  end

  task :restart do
    on roles(:app) do
      stop
      start
    end
  end
end
