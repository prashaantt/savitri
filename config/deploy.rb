require 'new_relic/recipes'
require 'rvm/capistrano'

set :rvm_ruby_string, 'ruby-1.9.3-p484@global'
set :user, 'ec2-user'
set :domain, '54.251.36.74'
set :application, "savitri"
set :repository, "git@github.com:nishantmodak/savitri.git"
set :deploy_to, "/home/#{user}/#{application}"
set :normalize_asset_timestamps, false
ssh_options[:keys] = '~/Dropbox/savitri/newsavitriserver.pem'
role :web, domain                          # Your HTTP server, Apache/etc
role :app, domain                          # This may be the same as your `Web` server
role :db,  domain, :primary => true # This is where Rails migrations will run
default_run_options[:shell] = false
default_run_options[:pty] = true
# miscellaneous options
set :deploy_via, :remote_cache
set :scm, 'git'
set :branch, 'master'
set :scm_verbose, true
set :use_sudo, false
set :shared_children, shared_children + %w{solr config/database.yml .env.production public/sitemap.xml.gz}
# Define all the tasks that need to be running manually after Capistrano is finished.
namespace :deploy do
	task :bundle_install, :roles => :app do
		run "cd #{release_path} && bundle install"
	end
end

after "deploy:update_code", :bundle_install
	desc "install the necessary prerequisites"
	task :bundle_install, :roles => :app do
		run "cd #{release_path} && ~/.rvm/gems/ruby-1.9.3-p484@global/bin/bundle install"
		run "cd #{release_path} && ~/.rvm/gems/ruby-1.9.3-p484@global/bin/rake assets:precompile"
		run "ln -nfs #{shared_path}/uploads  #{release_path}/public/uploads"
		#run "cd #{release_path} && bundle exec unicorn -c #{release_path}/config/unicorn.rb -D -E production -p 3000"
		#run "cd #{release_path} && rake sunsport:solr:stop"
		#run "cd #{release_path} && rake sunsport:solr:start"
	end

after "deploy:update", "newrelic:notice_deployment"
# desc "Zero-downtime restart of Unicorn"
# task :restart, :except => { :no_release => true } do
#   run "kill -s USR2 `cat #{shared_path}/pids/unicorn.pid`"
# end

# desc "Start unicorn"
# task :start, :except => { :no_release => true } do
#   run "cd #{current_path} ; bundle exec unicorn_rails -c config/unicorn.rb -D -E production"
# end

# desc "Stop unicorn"
# task :stop, :except => { :no_release => true } do
#   run "kill -s QUIT `cat #{shared_path}/pids/unicorn.pid`"
# end