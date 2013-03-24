set :user, 'ec2-user'
set :domain, 'ec2-54-251-105-152.ap-southeast-1.compute.amazonaws.com'
set :application, "savitri"
set :repository, "#{user}@#{domain}:git/#{application}.git"
set :deploy_to, "/home/#{user}/projects/#{application}"
set :normalize_asset_timestamps, false

role :web, domain                          # Your HTTP server, Apache/etc
role :app, domain                          # This may be the same as your `Web` server
role :db,  domain, :primary => true # This is where Rails migrations will run
default_run_options[:shell] = false
default_run_options[:pty] = true

# miscellaneous options
set :deploy_via, :remote_cache
set :scm, 'git'
set :branch, 'savtextsearch'
set :scm_verbose, true
set :use_sudo, false

# Define all the tasks that need to be running manually after Capistrano is finished.
namespace :deploy do
	task :bundle_install, :roles => :app do
		run "cd #{release_path} && bundle install"
	end
end

after "deploy:update_code", :bundle_install
	desc "install the necessary prerequisites"
	task :bundle_install, :roles => :app do
		run "cd #{release_path} && bundle install"
		run "cd #{release_path} && rake assets:precompile"
		run "cd #{release_path} && bundle exec unicorn -c #{release_path}/config/unicorn.rb -D -E production -p 3000"
		#run "cd #{release_path} && rake sunsport:solr:stop"
		#run "cd #{release_path} && rake sunsport:solr:start"
end