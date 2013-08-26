#require "bundler/capistrano"

server "10.12.0.69", :web, :app, :db, primary: true

set :appication, "site"
set :user, "fabsoft"
set :deploy_to, "/home/#{user}/#{appication}"
#set :deploy_via, :remote_cache
set :use_sudo, false

set :scm, "git"
set :repository, "git@github.com:felipegithub/site.git"
set :branch, "master"

# set :rake, "/usr/local/bin/rake"

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

after "deploy", "deploy:cleanup"

namespace :deploy do

	task :setup_config, roles: :app do
		sudo "ln -nfs #{current_path}/config/site.conf /etc/nginx/sites-enabled/#{appication}"
		# run "mkdir -p #{shared_path}/config"
		puts "Configuracoes Iniciais Prontas"
	end

	after "deploy:setup", "deploy:setup_config"
end

