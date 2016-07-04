# config valid only for current version of Capistrano
lock '3.4.1'

set :application, 'pmf'
set :repo_url, 'https://github.com/KernelCorp/pmf'

if File.exist?("./config/deploy_id_rsa")
  puts "file exist"
  set :ssh_options, keys: ["./config/deploy_id_rsa"]
else
  set :password, ask('Server password:', nil, echo: false)
end

set :linked_files, fetch(:linked_files, []).push('config/secrets.yml')

set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')

set :rails_env, 'production'
# puma
set :puma_user, fetch(:user)
set :puma_rackup, -> { File.join(current_path, 'config.ru') }
set :puma_state, "#{shared_path}/tmp/pids/puma.state"
set :puma_pid, "#{shared_path}/tmp/pids/puma.pid"
set :puma_bind, "unix://#{shared_path}/tmp/sockets/puma.sock"
set :puma_default_control_app, "unix://#{shared_path}/tmp/sockets/pumactl.sock"
set :puma_conf, "#{shared_path}/puma.rb"
set :puma_access_log, "#{shared_path}/log/puma_access.log"
set :puma_error_log, "#{shared_path}/log/puma_error.log"
set :puma_role, :app
set :puma_env, fetch(:rack_env, fetch(:rails_env, 'production'))
set :puma_threads, [0, 16]
set :puma_workers, 0
set :puma_worker_timeout, nil
set :puma_init_active_record, false
set :puma_preload_app, true
set :nginx_use_ssl, false
set :nginx_server_name, 'pmf.kerweb.ru'


namespace :deploy do

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
    end
  end

  task :seed do
    run "cd #{current_path}; bundle exec rake db:seed RAILS_ENV=production"
  end
end